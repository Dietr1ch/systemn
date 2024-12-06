{ pkgs, ... }:

# https://nixos.wiki/wiki/Yubikey
# https://github.com/drduh/YubiKey-Guide
{
  programs = {
    # https://search.nixos.org/options?channel=unstable&query=programs.ssh
    ssh = {
      startAgent = false;
    };
    # https://search.nixos.org/options?channel=unstable&query=programs.gnupg
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
      paperkey
      pinentry-curses
      pinentry-qt
      yubikey-personalization
    ];
  };
}
