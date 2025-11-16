{ pkgs, ... }:

{
  # NOTE: Kernel modules are kernel specific :/
  boot = {
    kernelModules = [
      # "new-lg4ff"
    ];
    # extraModulePackages = with pkgs; [
    #   # linuxPackages.new-lg4ff
    # ];
  };

  environment = {
    systemPackages = with pkgs; [
      oversteer
    ];
  };
}
