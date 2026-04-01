{ pkgs, ... }:

# https://nixos.wiki/wiki/Fonts
{
  fonts = {
    fontDir.enable = true;
    enableGhostscriptFonts = true;

    # In sync with ~/Projects/nixland/desktop/fonts.nix
    packages = with pkgs; [
      # Regular fonts
      # =============
      dejavu_fonts
      inconsolata
      liberation_ttf
      noto-fonts
      open-sans

      # ??
      dina-font
      proggyfonts
      terminus_font

      # Programming
      # ===========
      # Fira
      fira
      fira-mono
      fira-code
      fira-code-symbols
      fira-math
      iosevka

      # Icons, Symbols, Emoji
      # =====================
      emacs-all-the-icons-fonts
      font-awesome
      symbola

      powerline-fonts

      noto-fonts-color-emoji
    ]; # ..fonts.packages

    fontconfig = {
      enable = true;

      defaultFonts = {
        serif = [
          "Noto Serif"
          "Liberation Serif"
          "DejaVu Serif"
        ];
        sansSerif = [
          "Noto Sans"
          "Fira Sans"
          "Liberation Sans"
          "DejaVu Sans"
        ];
        monospace = [
          "Fira Code"
          "Iosevka"
        ];
      };
    }; # ..fonts.fontconfig
  }; # ..fonts
}
