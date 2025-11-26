{ ... }:

{
  hardware = {
    # https://search.nixos.org/options?channel=unstable&query=hardware.usb-modeswitch
    usb-modeswitch = {
      enable = true;
    };
  };

  boot = {
    # https://search.nixos.org/options?channel=unstable&query=boot.extraModprobeConfig
    # https://nixos.wiki/wiki/Linux_kernel#Customizing_kernel_module_parameters
    #
    # Generates,
    # - /etc/modprobe.d/
    extraModprobeConfig = ''
      # Wait 30s before auto-suspending hardware.
      # https://www.kernel.org/doc/Documentation/usb/power-management.txt
      options usbcore autosuspend=30
    '';
  };
}
