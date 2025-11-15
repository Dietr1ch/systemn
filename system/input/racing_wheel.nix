{ pkgs, ... }:

{
  boot = {
    kernelModules = [
      # "new-lg4ff"
    ];
    extraModulePackages = with pkgs; [
      linuxPackages.new-lg4ff
    ];
  };

  environment = {
    systemPackages = with pkgs; [
      oversteer
    ];
  };
}
