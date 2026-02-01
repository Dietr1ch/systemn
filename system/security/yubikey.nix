{ pkgs, ... }:

# https://nixos.wiki/wiki/Yubikey
# https://github.com/drduh/YubiKey-Guide
{
  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.udev
    udev = {
      packages = with pkgs; [
        yubikey-personalization
      ];
    };

    pcscd = {
      enable = true;
      plugins = with pkgs; [
        ccid

        pcsc-tools
      ];
    };
  };

  environment = {
    systemPackages = with pkgs; [
      age-plugin-yubikey

      yubikey-personalization
    ];
  };
}
