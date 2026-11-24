{ pkgs, ... }:

{
  imports = [
    # ./gaming
    # ./media
    # ./programming
    ./shell

    ./sound.nix
  ];

  environment = {
    systemPackages = with pkgs; [
      xdg-ninja
      xdg-user-dirs
    ];
  };
}
