{ config, pkgs, lib, ... }:

{
  boot = {
    kernel = {
      sysctl = {
        "vm.nr_hugepages" = 1024;  # 1024pages * 2MB/page = 2GB
      };
    };

    kernelParams = [
      # grep 'huge' /proc/meminfo
      # 4G will be reserved for huge pages
      # "hugepagesz=512M"
      # "hugepages=8"

      # By default only explicit hugepages request will use them
      # cat /sys/kernel/mm/transparent_hugepage/enabled
    ];
  };

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
          "ManagedOOMMemoryPressureLimit" = "95%";
          "ManagedOOMPreference" = "none";
          "ManagedOOMSwap" = "auto";
          "MemoryPressureThresholdUSec" = "200ms";
          "MemoryPressureWatch" = "auto";
        };
      };
      "system" = {
        sliceConfig = {
          "ManagedOOMMemoryPressure" = lib.mkForce "auto";
          "ManagedOOMMemoryPressureLimit" = "95%";
          "ManagedOOMPreference" = "none";
          "ManagedOOMSwap" = "auto";
          "MemoryPressureThresholdUSec" = "200ms";
          "MemoryPressureWatch" = "auto";
        };
      };
      "user-" = {
        sliceConfig = {
          "ManagedOOMMemoryPressure" = lib.mkForce "auto";
          "ManagedOOMMemoryPressureLimit" = "95%";
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
