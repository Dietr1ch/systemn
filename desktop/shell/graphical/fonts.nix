{ pkgs, ... }:

# https://nixos.wiki/wiki/Fonts
{
  fonts = {
    fontDir.enable = true;
    fontconfig.enable = true;
    enableGhostscriptFonts = true;

    packages = with pkgs; [
      # Regular fonts
      # =============
      dejavu_fonts
      inconsolata
      liberation_ttf
      noto-fonts

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

      # Icons, Symbols, Emoji
      # =====================
      emacs-all-the-icons-fonts
      font-awesome
      symbola

      powerline-fonts

      noto-fonts-color-emoji
    ];
  };
}
