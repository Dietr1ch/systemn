{ pkgs, ... }:

# https://nixos.wiki/wiki/Yubikey
# https://github.com/drduh/YubiKey-Guide
{
  programs = {
    # https://search.nixos.org/packages?channel=unstable&query=programs.gnupg
    ssh = {
      startAgent = false;
    };
    gnupg = {
      agent = {
        enableSSHSupport = true;
        enableBrowserSocket = true;
      };
      dirmngr = {
        enable = true;
      };
    };
  };

  services = {
    # https://search.nixos.org/packages?channel=unstable&query=services.udev
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
      paperkey
      pinentry-curses
      pinentry-qt
      yubikey-personalization
    ];
  };
}
