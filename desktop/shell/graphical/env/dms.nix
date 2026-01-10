{ pkgs, lib, ... }:

{
  programs = {
    # https://search.nixos.org/options?channel=unstable&query=programs.dms-shell
    dms-shell = {
      enable = true;

      enableAudioWavelength = lib.mkDefault true;
      enableCalendarEvents = lib.mkDefault true;
      enableClipboard = lib.mkDefault true;
      enableDynamicTheming = lib.mkDefault true;
      enableSystemMonitoring = lib.mkDefault true;
      enableVPN = lib.mkDefault false;

      systemd = {
        enable = true;
        restartIfChanged = true;

        target = "wayland-session.target";
      };
    };
  };

  environment = {
    systemPackages = with pkgs; [
      matugen
    ];
  };
}
