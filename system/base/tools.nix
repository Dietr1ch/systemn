{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      broot
      ripgrep
    ];
  };
}
