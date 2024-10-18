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

  environment = {
    systemPackages = with pkgs; [
      libhugetlbfs
    ];
  };
}
