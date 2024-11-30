{ config, pkgs, lib, ... }:

{
  systemd = {
    # https://search.nixos.org/options?channel=unstable&query=systemd.oomd
    oomd = {
      enableRootSlice = true;
      enableSystemSlice = true;
      enableUserSlices = true;

      # https://man.archlinux.org/man/systemd-oomd.8
      # https://man.archlinux.org/man/oomd.conf.5

      extraConfig = {
        "DefaultMemoryPressureDurationSec" = "20s";
      };
    };

    slices = {
      "-" = {
        sliceConfig = {
          "ManagedOOMMemoryPressure" = lib.mkForce "auto";
          "ManagedOOMMemoryPressureLimit" = 0;
          "ManagedOOMPreference" = "none";
          "ManagedOOMSwap" = "auto";
          "MemoryPressureThresholdUSec" = "200ms";
          "MemoryPressureWatch" = "auto";
        };
      };
      "system" = {
        sliceConfig = {
          "ManagedOOMMemoryPressure" = lib.mkForce "auto";
          "ManagedOOMMemoryPressureLimit" = 0;
          "ManagedOOMPreference" = "none";
          "ManagedOOMSwap" = "auto";
          "MemoryPressureThresholdUSec" = "200ms";
          "MemoryPressureWatch" = "auto";
        };
      };
      "user-" = {
        sliceConfig = {
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
