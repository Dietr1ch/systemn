{ pkgs, ... }:

{
  imports = [
    ./comms.nix
    ./gamemode.nix
    ./obs.nix
    ./steam.nix
    # ./wine.nix
  ];

  boot = {
    kernelModules = [
      "hid-nintendo"
    ];
  };

  users = {
    groups = {
      # Users that will play games (Higher limits)
      "games" = {
        gid = 666;
      };
    };
  };

  environment = {
    systemPackages = with pkgs; [
      openvr
    ];
  };
}
