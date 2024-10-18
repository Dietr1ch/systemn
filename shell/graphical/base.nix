{ pkgs, ... }:

# https://nixos.wiki/wiki/Fonts
{
  fonts = {
    fontDir.enable = true;
    fontconfig.enable = true;
    enableGhostscriptFonts = true;

    packages = with pkgs; [
      # corefonts
      inconsolata
      dejavu_fonts
      noto-fonts
      noto-fonts-emoji
      liberation_ttf
      fira-code
      fira-code-symbols

      # mplus-outline-fonts
      dina-font
      proggyfonts
      terminus_font

      powerline-fonts

      # Programming
      source-code-pro

      # https://www.nerdfonts.com/
      # https://discourse.nixos.org/t/home-manager-nerdfonts/11226/2
      (pkgs.nerdfonts.override {
        fonts = [
          "DroidSansMono"
          "FiraCode"
          "Hack"
          "RobotoMono"
          "Noto"
          "SourceCodePro"
          "Ubuntu"
        ];
      })

      emacs-all-the-icons-fonts
    ];
  };
}

