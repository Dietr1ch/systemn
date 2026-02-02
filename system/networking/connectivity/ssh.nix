{ config, pkgs, ... }:

{
  programs = {
    # https://search.nixos.org/options?channel=unstable&query=programs.ssh
    ssh = {
      startAgent = false;
    }; # ..programs.ssh

    # https://search.nixos.org/options?channel=unstable&query=programs.mosh
    mosh = {
      enable = true;
    }; # ..programs.mosh

    # Key agents on ../../security/yubikey.nix

    # https://search.nixos.org/options?channel=unstable&query=programs.gnupg
    gnupg = {
      # https://search.nixos.org/options?channel=unstable&query=programs.gnupg.agent
      agent = {
        enable = true;

        # pinentryPackage = "??"; # Set by the desktop environment.

        enableSSHSupport = true;
        enableExtraSocket = true;
        enableBrowserSocket = true;

        # https://www.gnupg.org/documentation/manuals/gnupg26/gpg-agent.1.html
        settings = {
          "default-cache-ttl" = 1 * 60; # Keep entries for 1m after each use.
          "max-cache-ttl" = 15 * 60; # Cache entries expire after 15m.
        }; # ..programs.gnupg.agent.settings
      }; # ..programs.gnupg.agent

      # https://search.nixos.org/options?channel=unstable&query=programs.gnupg.dirmngr
      dirmngr = {
        enable = true;
      }; # ..programs.gnupg.dirmngr
    }; # ..programs.gnupg
  }; # ..programs

  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.openssh
    openssh = {
      enable = true;

      startWhenNeeded = true;

      # https://search.nixos.org/options?channel=unstable&query=services.openssh.settings
      # /etc/ssh/sshd_config
      # man 5 sshd_config
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        ChallengeResponseAuthentication = false;
        PermitRootLogin = "no";
        PubkeyAuthentication = true;

        # https://wiki.gnupg.org/AgentForwarding
        StreamLocalBindUnlink = "yes";

        # Remote Environment
        # In sync with ~/Projects/nixland/networking/ssh.nix
        AcceptEnv = [
          "LANG"
          "LC_*"
          "ROAMING_SSH_HOSTNAME"
        ];
      };

      banner = ''
        ${config.networking.hostName}
      '';
    };
  }; # ..services

  systemd = {
    services = {
      sshd = {
        # https://www.freedesktop.org/software/systemd/man/systemd.service.html
        serviceConfig = {
          "OOMScoreAdjust" = -1000;
        };
      };
    };
  }; # ..systemd

  environment = {
    systemPackages = with pkgs; [
      wol

      paperkey
      pinentry-curses
      pinentry-qt

      sshfs-fuse
    ];
  }; # ..environment
}
