{ config, pkgs, lib, ... }:

{
  imports = [
    ./silent.nix
  ];

  boot = {
    kernelParams = [
      "splash"
    ];

    # https://search.nixos.org/options?channel=unstable&query=boot.plymouth
    plymouth = {
      enable = true;

      theme = lib.mkDefault "angular_alt";

      themePackages = with pkgs; [
        # Install only selected themes
        (adi1090x-plymouth-themes.override {
          # https://github.com/adi1090x/plymouth-themes?tab=readme-ov-file
          selected_themes = [
            # https://raw.githubusercontent.com/adi1090x/files/master/plymouth-themes/previews/1.gif
            "angular_alt"  # https://raw.githubusercontent.com/adi1090x/files/master/plymouth-themes/previews/5.gif
            "blockchain"  # https://raw.githubusercontent.com/adi1090x/files/master/plymouth-themes/previews/7.gif
            "deus_ex"  # https://raw.githubusercontent.com/adi1090x/files/master/plymouth-themes/previews/25.gif
            "flame"  # https://raw.githubusercontent.com/adi1090x/files/master/plymouth-themes/previews/29.gif
            "rings"
          ];
        })
      ];

      logo = "${pkgs.nixos-icons}/share/icons/hicolor/48x48/apps/nix-snowflake-white.png";
      extraConfig = ''
        UseFirmwareBackground=false
      '';
    };
  };
}
