{ pkgs, ... }:

{
  programs = {
    # https://search.nixos.org/options?channel=unstable&show=programs.gamemode.settings&query=gamemode
    gamemode = {
      enable = true;
      enableRenice = true;

      # https://wiki.archlinux.org/title/Gamemode
      # https://github.com/FeralInteractive/gamemode/blob/master/example/gamemode.ini
      settings = {
        general = {
          renice = 10;  # Use niceness -10
          ioprio = 0;  # iopriority of clients to BE/0
          desiredgov = "performance";
          softrealtime = "auto";

          inhibit_screensaver = 1;
        };
        custom = {
          start = "${pkgs.libnotify}/bin/notify-send --urgency 'low' --expire-time '15' 'GameMode started'";
          end   = "${pkgs.libnotify}/bin/notify-send --urgency 'low' --expire-time '15' 'GameMode ended'";
        };
      };
    };
  };

  users.groups = {
    # Users that will play games (Higher limits)
    "games" = {
      gid = 666;
    };
  };

  services = {
    udev = {
      extraRules = ''
        KERNEL=="cpu_dma_latency", GROUP="games"
      '';
    };
  };

  security = {
    sudo = {
      extraRules = [
        {
          groups = [
            "games"
          ];
          commands = [
            {
              command = "${pkgs.gamemode}/bin/gamemoderun";
              options = [ "NOPASSWD" ];
            }
            {
              command = "${pkgs.gamemode}/libexec/cpugovctl";
              options = [ "NOPASSWD" ];
            }
            {
              command = "${pkgs.gamemode}/libexec/procsysctl";
              options = [ "NOPASSWD" ];
            }
            {
              command = "${pkgs.gamemode}/libexec/gpuclockctl";
              options = [ "NOPASSWD" ];
            }
          ];
        }
      ];
    };
  };

  environment = {
    systemPackages = with pkgs; [
      coreutils
      gamemode

      libnotify
    ];
  };
}