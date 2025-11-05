{ pkgs, lib, ... }:

{
  imports = [
    ./default.nix
  ];

  console = {
    # This is supposed to be listed in,
    #   cat $(nix-build --no-out-link '<nixpkgs>' -A xkeyboard_config)/etc/X11/xkb/rules/base.lst
    #
    # - us-intl         ml: English (Mali, US, intl.)
    # - intl            by: Belarusian (intl.)
    # - qwerty          cm: Cameroon Multilingual (QWERTY, intl.)
    # - azerty          cm: Cameroon (AZERTY, intl.)
    # - dvorak          cm: Cameroon (Dvorak, intl.)
    # - intl            gb: English (UK, intl., with dead keys)
    # - mac_intl        gb: English (UK, Macintosh, intl.)
    # - intl            us: English (US, intl., with dead keys)
    # - alt-intl        us: English (US, alt. intl.)
    # - altgr-intl      us: English (intl., with AltGr dead keys)
    # - dvorak-intl     us: English (Dvorak, intl., with dead keys)
    # - dvorak-alt-intl us: English (Dvorak, alt. intl.)
    # - workman-intl    us: English (Workman, intl., with dead keys)
    # - us_dvorak       se: Swedish (Dvorak, intl.)
    # - intl            tr: Turkish (intl., with dead keys)
    #
    # However, that doesn't work
    #
    # https://search.nixos.org/options?channel=unstable&query=console.keyMap
    keyMap = lib.mkDefault "us";
    packages = with pkgs; [
      kbd
    ];
  };

  services = {
    xserver = {
      exportConfiguration = true;
      xkb = {
        layout = "us";
        variant = "intl";
      };
    };
  };
}
