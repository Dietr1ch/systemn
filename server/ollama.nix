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
    # ```fish
    # for capability in 'thinking' 'tools' 'completion' 'vision' 'insert'
    #   echo "$capability = ["
    #   for model in (ollama list | gawk 'NR>1 {print $1}' | sort)
    #     ollama show $model | grep -A10 'Capabilities' | grep "    $capability" >/dev/null && echo "  \"$model\""
    #   end
    #   echo "];"
    # end
    # ```

    thinking = [
      "deepseek-r1:latest"
      "magistral:latest"
      "qwen3:14b"
      "qwen3:32b"
      "qwen3:latest"
    ];
    # NOTE: Models require `tools` to be used by coding agents
    tools = [
      "magistral:latest"
      "qwen2.5-coder:14b"
      "qwen2.5-coder:3b"
      "qwen2.5-coder:7b"
      "qwen3:14b"
      "qwen3:32b"
      "qwen3-coder:30b"
      "qwen3:latest"
      "qwq:latest"
    ];
    completion = [
      "deepseek-coder-v2:16b"
      "deepseek-r1:latest"
      "gemma3:latest"
      "magistral:latest"
      "phi4:latest"
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
        "deepseek-r1" # https://ollama.com/library/deepseek-r1
        "gemma3" # https://ollama.com/library/gemma3
        "qwq" # https://ollama.com/library/qwq
      ];

      # NOTE: Check ~ollama serve --help~
      environmentVariables = {
        "OLLAMA_KEEP_ALIVE" = lib.mkDefault "5m"; # The duration that models stay loaded in memory (default "5m")

        # Default context length of 4kB is too small for many tasks
        # - https://docs.ollama.com/context-length
        "OLLAMA_CONTEXT_LENGTH" = lib.mkDefault (toString (256 * 1024));
      };
    }; # ..services.ollama

    # https://search.nixos.org/options?channel=unstable&query=services.litellm
    litellm = {
      enable = true;

      port = lib.mkDefault 11435;

      # https://docs.litellm.ai/docs/proxy/configs
      # https://github.com/anthropics/claude-code/issues/7178#issuecomment-3256343381
      settings = {
        model_list = (
          map (model: {
            # NOTE: Models need their parameters known in advance :/
            # - https://github.com/BerriAI/litellm/issues/11680
            model_name = "ollama/${model}";
            litellm_params = {
              model = "ollama/${model}";
              api_base = "http://localhost:${toString config.services.ollama.port}";

              allowed_openai_params = [
                "reasoning_effort" # NOTE: I guess it's fine to always allow the parameter
                "thinking"
              ];
            };
            model_info = {
              supports_reasoning = lib.mkDefault (builtins.elem model model_support.thinking);
            };
          }) config.services.ollama.loadModels
        );

        router_settings = {
          model_group_alias = {
            # FIXME: Figure out what to do with "claude-haiku-4-5-20251001" calls
            # Route haiku calls to local qwen2.5-coder:3b
            # "claude-haiku-4-5-20251001" = "ollama/qwen2.5-coder:3b";
          };
        };
      };
    }; # ..services.litellm
  }; # ..services

  # Integrations
  # ------------
  programs = {
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
