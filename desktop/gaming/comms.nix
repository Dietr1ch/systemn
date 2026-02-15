{ pkgs, ... }:

{
  environment = {
    # In Sync with ~/Projects/nixland/gaming/comms.nix
    systemPackages = with pkgs; [
      revolt-desktop
    ];
  };
}
