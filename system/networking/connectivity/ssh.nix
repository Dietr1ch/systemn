{
  config,
  pkgs,
  ...
}:

{
  programs = {
    mosh = {
      enable = true;
    }; # ..programs.mosh

    # Key agents on ../../security/yubikey.nix

    # https://search.nixos.org/options?channel=unstable&show=programs.gnupg.agent.enable&query=programs.gnupg
    gnupg = {
      agent = {
        enable = true;

        # pinentryPackage = "??";  # User controlled

        enableSSHSupport = true;
        enableExtraSocket = true;
        enableBrowserSocket = true;

        # https://www.gnupg.org/documentation/manuals/gnupg26/gpg-agent.1.html
        settings = {
          # default-cache-ttl = 60; # 1m  # Set by ../../security/yubikey.nix
        }; # ..programs.gnupg.agent.settings
      }; # ..programs.gnupg.agent
    }; # ..programs.gnupg
  }; # ..programs

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







