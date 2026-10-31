{ pkgs, lib, ... }:

{
  # Mirrors ~/Projects/nixland/desktop/spelling.nix
  environment = {
    sessionVariables = {
      DICTIONARY = lib.mkDefault "en_AU";
      DICPATH = lib.mkDefault "${pkgs.hunspell}/bin/hunspell";
    };

    systemPackages = with pkgs; [
      ispell

      hunspell
      hunspellDicts.en_AU-large

      harper
    ]; # ..environment.systemPackages
  }; # ..environment
}
