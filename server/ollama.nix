{
  config,
  pkgs,
  lib,
  ...
}:

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
            model_name = "ollama-${model}";
            litellm_params = {
              model = "ollama/${model}";
              api_base = "http://localhost:${toString config.services.ollama.port}";
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
