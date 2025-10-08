{
  pkgs,
  lib,
  ...
}:

{
  systemd = {
    # https://search.nixos.org/options?channel=unstable&query=systemd.oomd
    oomd = {
      # Run on all slices
      enableRootSlice = true; # /etc/systemd/system/-.slice
      enableSystemSlice = true; # /etc/systemd/system/system.slice
      enableUserSlices = true; # /etc/systemd/system/user.slice

      # /etc/systemd/oomd.conf
      # https://man.archlinux.org/man/systemd-oomd.8
      # https://man.archlinux.org/man/oomd.conf.5.en
      settings = {
        OOM = {
          DefaultMemoryPressureDurationSec = "20s";
          DefaultMemoryPressureLimit = "60%";
          SwapUsedLimit = "80%";
        };
      };
    };

    # https://search.nixos.org/options?channel=unstable&query=systemd.slices
    # https://www.freedesktop.org/software/systemd/man/latest/systemd.resource-control.html
    slices = {
      # Root slice
      # /etc/systemd/system/-.slice
      "-" = {
        sliceConfig = {
          "ManagedOOMMemoryPressure" = lib.mkForce "auto";
          "ManagedOOMMemoryPressureLimit" = 0;
          "ManagedOOMPreference" = "none";
          "ManagedOOMSwap" = "kill";
          "MemoryPressureWatch" = "auto";
        };
      };

      # System slice
      # /etc/systemd/system/system.slice
      "system" = {
        sliceConfig = {
          "ManagedOOMMemoryPressure" = lib.mkForce "kill";
          "ManagedOOMMemoryPressureLimit" = "60%";
          "ManagedOOMPreference" = "none";
          "ManagedOOMSwap" = "kill";
          "MemoryPressureWatch" = "auto";
        };
      };

      # User slices
      # /etc/systemd/system/user.slice
      # /etc/systemd/system/user@.service
      "user" = {
        sliceConfig = {
          "ManagedOOMMemoryPressure" = lib.mkForce "kill";
          "ManagedOOMMemoryPressureLimit" = "80%";
          "ManagedOOMPreference" = "none";
          "ManagedOOMSwap" = "kill";
          "MemoryPressureThresholdUSec" = "200ms";
          "MemoryPressureWatch" = "auto";
        };
      };
    };
  };

  environment = {
    systemPackages = with pkgs; [
      libhugetlbfs
    ];
  };
}
