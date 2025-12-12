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

      # https://search.nixos.org/options?channel=unstable&query=programs.gnupg.agent
      agent = {
        enable = true;

        # pinentryPackage = "??"; # Set by the desktop environment.

        enableSSHSupport = true;
        enableBrowserSocket = true;
        enableExtraSocket = true;

        # https://www.gnupg.org/documentation/manuals/gnupg26/gpg-agent.1.html
        settings = {
          "default-cache-ttl" = 1 * 60; # Keep entries for 1m after each use.
          "max-cache-ttl" = 15 * 60; # Cache entries expire after 15m.
        };
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
