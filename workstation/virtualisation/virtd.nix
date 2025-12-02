{ pkgs, ... }:

# https://nixos.wiki/wiki/Virt-manager
# https://nixos.wiki/wiki/Libvirt
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

    libvirtd = {
      enable = true;

      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
      };
    };
  };

  environment = {
    systemPackages = with pkgs; [
      virt-manager
    ];
  };
}
