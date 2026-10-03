{ pkgs, lib, ... }:

let
  hdd_autosuspend_secs = 5 * 60; # 5m

  # Value is a 5s multiplier when [1-240] (thus [5s-20m]), and a 30m multiplier in [241-251] (thus [30m-5h30m])
  hdd_autosuspend_value = hdd_autosuspend_secs / 5;
in
{
  services = {
    udev = {
      extraRules = ''
        ACTION=="add|change", SUBSYSTEM=="block", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="1", RUN+="${pkgs.hdparm}/bin/hdparm -S ${lib.toString hdd_autosuspend_value} /dev/%k"
      '';
    }; # ..services.udev
  }; # ..services

  environment = {
    systemPackages = with pkgs; [
      quota

      iotop

      hdparm
    ]; # ..environment.systemPackages
  }; # ..environment
}
