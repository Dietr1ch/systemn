{
  config,
  pkgs,
  lib,
  ...
}:

let
  # NOTE: Check with ~ollama show~
  # ```fish
  #   for model in (ollama list | gawk 'NR>1 {print $1}' | sort)
  #     ollama show $model | grep 'thinking' >/dev/null && echo $model
  #   end
  # ```
  known_thinking_models = [
    "deepseek-r1:latest"
    "magistral:latest"
    "qwen3:14b"
    "qwen3:32b"
    "qwen3:latest"
  ];
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
      loadModels = [
        "deepseek-r1" # https://ollama.com/library/deepseek-r1
        "gemma3" # https://ollama.com/library/gemma3
        "qwq" # https://ollama.com/library/qwq
      ];
    };

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
                "reasoning_effort"  # NOTE: I guess it's fine to always allow the parameter
              ];
            };
            model_info = {
              supports_reasoning = lib.mkDefault (builtins.elem model known_thinking_models);
            };
          }) config.services.ollama.loadModels
        );
      };
    };
  };

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
  };
}
