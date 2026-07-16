{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      # TODO: Add cryfs once v2 comes out and restores FUSE 3 support
      cryptsetup
    ];
  };
}
