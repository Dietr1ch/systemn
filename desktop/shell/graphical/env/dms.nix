{ pkgs, lib, ... }:

{
  programs = {
    # https://search.nixos.org/options?channel=unstable&query=programs.dms-shell
    dms-shell = {
      enable = true;

      enableAudioWavelength = lib.mkDefault true;
      enableCalendarEvents = lib.mkDefault true;
      enableDynamicTheming = lib.mkDefault true;
      enableSystemMonitoring = lib.mkDefault true;
      enableVPN = lib.mkDefault false;

      systemd = {
        enable = true;
        restartIfChanged = true;

        # https://danklinux.com/docs/dankmaterialshell/installation#compositor-specific-systemd-setup
        target = lib.mkDefault "hyprland-session.target";
      };
    }; # ..programs.dms-shell
  }; # ..programs

  environment = {
    systemPackages = with pkgs; [
      matugen
    ];
  }; # ..environment
}
