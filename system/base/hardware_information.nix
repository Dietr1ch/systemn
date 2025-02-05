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
      vulkan-tools

      procps  # /proc
      lm_sensors
    ];
  };
}
