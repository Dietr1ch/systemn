{ pkgs, ... }:

let
  gaming_gov = "performance";
  default_gov = "balanced";
in
{
  programs = {
    # https://search.nixos.org/options?channel=unstable&query=programs.gamemode
    gamemode = {
      enable = true;
      enableRenice = true;

      # https://wiki.archlinux.org/title/Gamemode
      # https://github.com/FeralInteractive/gamemode/blob/master/example/gamemode.ini
      settings = {
        general = {
          renice = 10; # Use niceness -10
          ioprio = 0; # iopriority of clients to BE/0
          desiredgov = gaming_gov;
          softrealtime = "auto";

          inhibit_screensaver = 1;
        };
        # /etc/gamemode.ini
        custom =
          let
            start = pkgs.writeShellScriptBin "gamemode_start_hook" ''
              ${pkgs.libnotify}/bin/notify-send --urgency 'low' --expire-time '1500' 'GameMode started'
              ${pkgs.kdePackages.qttools}/bin/qdbus org.kde.KWin /Compositor suspend
              ${pkgs.power-profiles-daemon}/bin/powerprofilesctl set ${gaming_gov}
            '';
            end = pkgs.writeShellScriptBin "gamemode_end_hook" ''
              ${pkgs.kdePackages.qttools}/bin/qdbus org.kde.KWin /Compositor resume
              ${pkgs.libnotify}/bin/notify-send --urgency 'low' --expire-time '1500' 'GameMode ended'
              ${pkgs.power-profiles-daemon}/bin/powerprofilesctl set  ${default_gov}
            '';
          in
          {
            script_timeout = 5;
            start = "${start}/bin/gamemode_start_hook";
            end = "${end}/bin/gamemode_end_hook";
          };
      };
    };

    # https://search.nixos.org/options?channel=unstable&query=programs.steam
    steam = {
      package = pkgs.steam.override {
        extraPkgs = (
          pkgs: with pkgs; [
            gamemode
          ]
        );
      };
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
      gamemode
      libnotify
    ];
  };
}
