{
  config,
  pkgs,
  lib,
  ...
}:

{
  boot = {
    kernelParams = [
      # "copytoram"  # I'm not sure it really benefits performance
    ];
  };
}
