{ pkgs, ... }:

{
  # Rules for mounting TrueRNG. https://ubld.it/truerng_v3
  services.udev.extraRules = ''
    SUBSYSTEM=="tty", ATTRS{product}=="TrueRNG", SYMLINK+="TrueRNG", RUN+="${pkgs.coreutils}/bin/stty raw -echo -ixoff -F /dev/%k speed 3000000"
    ATTRS{idVendor}=="04d8", ATTRS{idProduct}=="f5fe", ENV{ID_MM_DEVICE_IGNORE}="1"
  '';

  environment = {
    systemPackages = with pkgs; [
      coreutils
    ];
  };
}
