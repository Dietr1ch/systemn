{ pkgs, lib, ... }:

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
          # The reaper thread will check every 5 seconds for exited clients, for
          # config file changes, and for the CPU/iGPU power balance
          reaper_freq = lib.mkDefault 5; # 5s

          # The desired governor is used when entering GameMode instead of "performance"
          desiredgov = gaming_gov;
          # The default governor is used when leaving GameMode instead of restoring the original value
          defaultgov = lib.mkDefault default_gov;

          # GameMode can change the scheduler policy to SCHED_ISO on kernels which support it (currently
          # not supported by upstream kernels). Can be set to "auto", "on" or "off". "auto" will enable
          # with 4 or more CPU cores. "on" will always enable. Defaults to "off".
          softrealtime = lib.mkDefault "auto";

          # GameMode can renice game processes. You can put any value between 0 and 20 here, the value
          # will be negated and applied as a nice value (0 means no change). Defaults to 0.
          # To use this feature, the user must be added to the gamemode group (and then rebooted):
          # sudo usermod -aG gamemode $(whoami)
          renice = lib.mkDefault 10; # Use niceness -10

          # By default, GameMode adjusts the iopriority of clients to BE/0, you can put any value
          # between 0 and 7 here (with 0 being highest priority), or one of the special values
          # "off" (to disable) or "reset" (to restore Linux default behavior based on CPU priority),
          # currently, only the best-effort class is supported thus you cannot set it here
          ioprio = lib.mkDefault 0; # iopriority of clients to BE/0

          # Sets whether gamemode will inhibit the screensaver when active. Defaults to 1
          inhibit_screensaver = lib.mkDefault 1;

          # Sets whether gamemode will disable split lock mitigation when active. Defaults to 1.
          disable_splitlock = lib.mkDefault 1;
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
