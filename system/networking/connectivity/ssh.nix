{ config, lib, pkgs, ... }:

{
  programs = {
    mosh.enable = true;
  };

  services = {
    openssh = {
      enable = true;

      # /etc/ssh/sshd_config
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
        PubkeyAuthentication = true;
      };

      banner = ''
        ${config.networking.hostName}
      '';
    };
  };

  environment = {
    systemPackages = with pkgs; [
      sshfs-fuse
    ];
  };
}
