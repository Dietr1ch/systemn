{ pkgs, ... }:

# https://nixos.wiki/wiki/Fonts
{
  fonts = {
    fontDir.enable = true;
    fontconfig.enable = true;
    enableGhostscriptFonts = true;

    packages = with pkgs; [
      # corefonts
      dejavu_fonts
      inconsolata
      liberation_ttf
      noto-fonts
      # ??
      dina-font
      proggyfonts
      terminus_font

      # Programming
      fira-code
      fira-code-nerdfont
      fira-code-symbols


      # Icons, Symbols, Emoji
      emacs-all-the-icons-fonts
      font-awesome

      powerline-fonts

      emojione
      noto-fonts-emoji
    ];
  };
}

