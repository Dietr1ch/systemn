{ pkgs, config, ... }:

{
  boot = {
    extraModulePackages = [
      config.boot.kernelPackages.lttng-modules
    ];
  };

  # TODO add systemd services and groups (consider upstreaming support)
}
