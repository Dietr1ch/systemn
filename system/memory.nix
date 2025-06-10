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

      # https://man.archlinux.org/man/systemd-oomd.8
      # https://man.archlinux.org/man/oomd.conf.5

      extraConfig = {
        "DefaultMemoryPressureDurationSec" = "20s";
      };
    };

    # https://search.nixos.org/options?channel=unstable&query=systemd.slices
    slices = {
      # /etc/systemd/system/-.slice
      "-" = {
        sliceConfig = {
          "ManagedOOMMemoryPressure" = lib.mkForce "auto";
          "ManagedOOMMemoryPressureLimit" = 0;
          "ManagedOOMPreference" = "none";
          "ManagedOOMSwap" = "auto";
          "MemoryPressureWatch" = "auto";
        };
      };

      # /etc/systemd/system/system.slice
      "system" = {
        sliceConfig = {
          "ManagedOOMMemoryPressure" = lib.mkForce "auto";
          "ManagedOOMMemoryPressureLimit" = 0;
          "ManagedOOMPreference" = "none";
          "ManagedOOMSwap" = "auto";
          "MemoryPressureWatch" = "auto";
        };
      };

      # /etc/systemd/system/user.slice
      # /etc/systemd/system/user@.service
      "user" = {
        sliceConfig = {
          # https://man.archlinux.org/man/systemd.resource-control.5.en#Memory_Pressure_Control
          "ManagedOOMMemoryPressure" = lib.mkForce "auto";
          "ManagedOOMMemoryPressureLimit" = 0;
          "ManagedOOMPreference" = "none";
          "ManagedOOMSwap" = "auto";
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
