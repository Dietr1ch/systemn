{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      gpu-viewer
    ];
  };
}
