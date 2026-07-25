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
      "deepseek-r1:latest"
      "magistral:latest"
      "qwen3:14b"
      "qwen3:32b"
      "qwen3:latest"
      "qwen3.5:2b"
      "qwen3.5:4b"
      "qwen3.5:9b"
      "qwen3.5:27b"
    ];
    # NOTE: Models require `tools` to be used by coding agents
    tools = [
      "llama3.1:8b"
      "magistral:latest"
      "qwen2.5-coder:14b"
      "qwen2.5-coder:3b"
      "qwen2.5-coder:7b"
      "qwen3:14b"
      "qwen3:32b"
      "qwen3-coder:30b"
      "qwen3:latest"
      "qwq:latest"
      "qwen3.5:2b"
      "qwen3.5:4b"
      "qwen3.5:9b"
      "qwen3.5:27b"
    ];
    completion = [
      "deepseek-coder-v2:16b"
      "deepseek-r1:latest"
      "gemma3:latest"
      "magistral:latest"
      "phi4:14b"
      "qwen2.5-coder:14b"
      "qwen2.5-coder:3b"
      "qwen2.5-coder:7b"
      "qwen3:14b"
      "qwen3:32b"
      "qwen3-coder:30b"
      "qwen3:latest"
      "qwq:latest"
    ];
    vision = [
      "gemma3:latest"
      "qwen3.5:2b"
      "qwen3.5:4b"
      "qwen3.5:9b"
      "qwen3.5:27b"
    ];
    insert = [
      "deepseek-coder-v2:16b"
      "qwen2.5-coder:14b"
      "qwen2.5-coder:3b"
      "qwen2.5-coder:7b"
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
        # https://www.canirun.ai/
        "qwen3.5:9b" # https://ollama.com/library/qwen3.5:9b
        "phi4:14b" # https://ollama.com/library/phi4:14b
        "llama3.1:8b" # https://ollama.com/library/llama3.1:8b
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
        model = "deepseek-r1";
        url = "http://127.0.0.1:${toString config.services.ollama.port}/v1/chat/completions";
      };
    };
  }; # ..programs

  environment = {
    systemPackages = with pkgs; [
      opencode
    ]; # ..environment.systemPackages
  }; # ..environment
}
