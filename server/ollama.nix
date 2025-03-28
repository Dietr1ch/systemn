{ ... }:

{
  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.ollama
    # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/services/misc/ollama.nix
    ollama = {
      enable = true;

      openFirewall = true;

      # Models: https://ollama.com/library
      loadModels = [
        "deepseek-r1"  # https://ollama.com/library/deepseek-r1
        "gemma3"  # https://ollama.com/library/gemma3
        "qwq"  # https://ollama.com/library/qwq
      ];
    };
  };
}
