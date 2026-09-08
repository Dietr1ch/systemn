{
  config,
  pkgs,
  lib,
  ...
}:

let
  model_support = {
    # NOTE: Check with ~ollama show~
    #
    # #+begin_src fish :results raw
    #   for capability in 'thinking' 'tools' 'completion' 'vision' 'insert'
    #     echo "$capability = ["
    #     for model in (ollama list | gawk 'NR>1 {print $1}' | sort)
    #       ollama show $model | grep -A10 'Capabilities' | grep "    $capability" >/dev/null && echo "  \"$model\""
    #     end
    #     echo "];"
    #   end
    # #+end_src

    thinking = [
      "hf.co/unsloth/Qwen3.8-27B-GGUF:UD-Q2_K_XL"
      "hf.co/unsloth/Qwen3.8-27B-GGUF:UD-IQ3_XXS"
      "hf.co/unsloth/Qwen3.8-27B-GGUF:UD-Q3_K_XL"
      "qwen3.5:9b"
    ];
    tools = [
      "hf.co/unsloth/Qwen3.8-27B-GGUF:UD-Q2_K_XL"
      "hf.co/unsloth/Qwen3.8-27B-GGUF:UD-IQ3_XXS"
      "hf.co/unsloth/Qwen3.8-27B-GGUF:UD-Q3_K_XL"
      "qwen2.5-coder:3b"
      "qwen2.5-coder:7b"
      "qwen2.5-coder:14b"
    ];
    completion = [
      "hf.co/unsloth/Qwen3.8-27B-GGUF:UD-Q2_K_XL"
      "hf.co/unsloth/Qwen3.8-27B-GGUF:UD-IQ3_XXS"
      "hf.co/unsloth/Qwen3.8-27B-GGUF:UD-Q3_K_XL"
      "qwen2.5-coder:3b"
      "qwen2.5-coder:7b"
      "qwen2.5-coder:14b"
    ];
    vision = [
      "hf.co/unsloth/Qwen3.8-27B-GGUF:UD-Q2_K_XL"
      "hf.co/unsloth/Qwen3.8-27B-GGUF:UD-IQ3_XXS"
      "hf.co/unsloth/Qwen3.8-27B-GGUF:UD-Q3_K_XL"
    ];
    insert = [
      "qwen2.5-coder:3b"
      "qwen2.5-coder:7b"
      "qwen2.5-coder:14b"
    ];
  };
in
{
  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.ollama
    # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/services/misc/ollama.nix
    ollama = {
      enable = true;
      package = lib.mkDefault pkgs.ollama-vulkan;

      port = lib.mkDefault 11434;

      # Models: https://ollama.com/library
      syncModels = lib.mkDefault true; # Cleanup models not in loadModels
      loadModels = [
        "hf.co/unsloth/Qwen3.8-27B-GGUF:UD-Q2_K_XL" # https://huggingface.co/unsloth/Qwen3.8-27B-GGUF?show_file_info=Qwen3.8-27B-UD-Q2_K_XL.gguf
        "hf.co/unsloth/Qwen3.8-27B-GGUF:UD-IQ3_XXS" # https://hf.co/unsloth/Qwen3.8-27B-GGUF?show_file_info=Qwen3.8-27B-UD-IQ3_XXS.gguf
        "hf.co/unsloth/Qwen3.8-27B-GGUF:UD-Q3_K_XL" # https://huggingface.co/unsloth/Qwen3.8-27B-GGUF?show_file_info=Qwen3.8-27B-UD-Q3_K_XL.gguf
        "qwen2.5-coder:3b" # https://ollama.com/library/qwen2.5-coder:3b
        "qwen2.5-coder:7b" # https://ollama.com/library/qwen2.5-coder:7b
        "qwen2.5-coder:14b" # https://ollama.com/library/qwen2.5-coder:14b
      ];

      # NOTE: Check ~ollama serve --help~
      environmentVariables = {
        "OLLAMA_KEEP_ALIVE" = lib.mkDefault "5m"; # The duration that models stay loaded in memory (default "5m")

        # Default context length of 4kB is too small for many tasks
        # - https://docs.ollama.com/context-length
        "OLLAMA_CONTEXT_LENGTH" = lib.mkDefault (toString (256 * 1024));
      };
    }; # ..services.ollama
  }; # ..services

  # Integrations
  # ------------
  programs = {
    # :/desktop/shell/terminal/pay-respects.nix
    pay-respects = {
      aiIntegration = {
        locale = "en-GB";
        model = "qwen2.5-coder:14b";
        url = "http://127.0.0.1:${toString config.services.ollama.port}/v1/chat/completions";
      };
    };
  }; # ..programs

  environment = {
    systemPackages = with pkgs; [
      opencode
      snip
    ]; # ..environment.systemPackages
  }; # ..environment
}
