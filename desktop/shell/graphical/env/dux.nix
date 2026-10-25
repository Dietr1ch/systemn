{ pkgs, ... }:

{
  programs = {
    # https://search.nixos.org/options?channel=unstable&query=programs.dux-shell
    # https://duxlabs.dev/docs/dms/nixos
    dux-shell = {
      enable = true;

      systemd = {
        enable = true;
        restartIfChanged = true;
      };
    }; # ..programs.dms-shell
  }; # ..programs

  environment = {
    systemPackages = with pkgs; [ matugen ];
  }; # ..environment
}
