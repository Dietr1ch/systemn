{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs = {
    mosh = {
      enable = true;
    };
    # Key agents on ../../security/yubikey.nix
  };

  services = {
    openssh = {
      enable = true;

      startWhenNeeded = true;

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

  systemd = {
    services = {
      sshd = {
        # https://www.freedesktop.org/software/systemd/man/systemd.service.html
        serviceConfig = {
          "OOMScoreAdjust" = -1000;
        };
      };
    };
  };

  environment = {
    systemPackages = with pkgs; [
      sshfs-fuse
    ];
  };
}
