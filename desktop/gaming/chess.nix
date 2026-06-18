{ pkgs, ... }:

{
  environment = {
    # Packages in sync with ~/Projects/nixland/gaming/chess.nix
    systemPackages = with pkgs; [
      stockfish
      uchess
      gnuchess
      en-croissant
    ];
  };
}
