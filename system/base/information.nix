{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      lshw  # Hardware
      lsof  # Open files

      clinfo  # OpenCL
      pciutils
      usbutils
      glxinfo

      htop
      nethogs

      procps  # /proc
      lm_sensors
    ];
  };
}
