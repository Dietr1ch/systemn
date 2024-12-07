{ pkgs, ... }:

{
  programs = {
    virt-manager = {
      enable = true;
    };
  };

  virtualisation = {
    containers = {
      # Enable common container config files in /etc/containers
      enable = true;
    };

    # https://nixos.wiki/wiki/Virt-manager
    libvirtd = {
      enable = true;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      virt-manager
    ];
  };
}
