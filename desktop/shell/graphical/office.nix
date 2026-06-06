{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      # BROKEN: libreoffice-qt6-fresh
      libreoffice-qt6
      kdePackages.okular
    ];
  };
}
