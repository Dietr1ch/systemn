{ pkgs, lib, ... }:

{
  imports = [
    ./default.nix
  ];

  console = {
    # This is supposed to be listed in,
    #   cat $(nix-build --no-out-link '<nixpkgs>' -A xkeyboard_config)/etc/X11/xkb/rules/base.lst
    #
    # - dvorak-intl     us: English (Dvorak, intl., with dead keys)
    # - dvorak-alt-intl us: English (Dvorak, alt. intl.)
    # - dvp             us: English (programmer Dvorak)
    # - dvorak          de: German (Dvorak)
    # - dvorak          es: Spanish (Dvorak)
    # - dvorak          latam: Spanish (Latin American, Dvorak)
    #
    # However, that doesn't work
    #
    # https://search.nixos.org/options?channel=unstable&query=console.keyMap
    keyMap = lib.mkDefault "dvorak-programmer";
    packages = with pkgs; [
      kbd
    ];
  };

  services = {
    xserver = {
      exportConfiguration = true;
      xkb = {
        layout = "us";
        variant = "dvp";
      };
    };
  };
}
