{ lib, ... }:

{
  boot = {
    kernelParams = [
      # "copytoram"  # I'm not sure it really benefits performance
    ];

    loader = {
      timeout = lib.mkDefault 5;
    };
  };
}
