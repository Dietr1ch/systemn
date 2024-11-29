{ config, pkgs, lib, ... }:

{
  boot = {
    kernel = {
      sysctl = {
        "vm.nr_hugepages" = 8 * 1024;  # 8MB
      };
    };

    kernelParams = [
      # grep 'huge' /proc/meminfo
      # 8G will be reserved for huge pages
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
      # extraConfig = ''
      # '';
    };
  };

  environment = {
    systemPackages = with pkgs; [
      libhugetlbfs
    ];
  };
}
