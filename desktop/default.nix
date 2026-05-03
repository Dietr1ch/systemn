{ pkgs, ... }:

{
  imports = [
    # ./gaming # ./gaming/default.nix
    # ./programming # ./programming/default.nix
    ./shell # ./shell/default.nix

    ./sound.nix
  ];

  environment = {
    systemPackages = with pkgs; [
      xdg-ninja
      xdg-user-dirs
    ];
  };
}
