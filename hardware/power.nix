{ ... }:

{
  boot = {
    # https://search.nixos.org/options?channel=unstable&query=boot.extraModprobeConfig
    extraModprobeConfig = ''
      # https://www.kernel.org/doc/Documentation/usb/power-management.txt
      # Wait 30s before auto-suspending hardware.
      options usbcore autosuspend=30
    '';
  };

  powerManagement = {
    enable = true;

    # https://search.nixos.org/options?channel=unstable&query=powerManagement.powertop
    powertop = {
      enable = true;
    };
  };

  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.acpid
    acpid = {
      enable = true;
    };
  };
}
