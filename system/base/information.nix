{ pkgs, config, ... }:

{
  boot = {
    extraModulePackages = [
      config.boot.kernelPackages.lttng-modules
    ];
  };

  environment = {
    systemPackages = with pkgs; [
      htop
      nethogs
    ];
  };
}
