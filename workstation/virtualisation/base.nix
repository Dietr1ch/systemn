{ ... }:

{
  boot = {
    kernelModules = [
      "vfio-pci" # https://nixos.mayflower.consulting/blog/2020/06/17/windows-vm-performance/
    ];
  };
}
