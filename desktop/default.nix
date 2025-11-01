{ pkgs, ... }:

{
  imports = [
    ./shell # ./shell/default.nix
    # ./gaming # ./gaming/default.nix

    ./sound.nix
  ];

  environment = {
    systemPackages = with pkgs; [
      xdg-user-dirs
    ];
  };
}
