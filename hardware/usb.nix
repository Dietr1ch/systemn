{ ... }:

{
  hardware = {
    # https://search.nixos.org/options?channel=unstable&query=hardware.usb-modeswitch
    usb-modeswitch = {
      enable = true;
    };
  };

  boot = {
    extraModprobeConfig = ''
      options usbcore  autosuspend=30  # Bump USB auto-suspend time to 30s
    '';
  };
}
