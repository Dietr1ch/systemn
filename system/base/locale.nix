{ config, lib, pkgs, ... }:

{
  i18n = {
    defaultLocale = lib.mkDefault "en_GB.UTF-8";
    # ../../secrets.nix
    # supportedLocales = [
    #   "de_CH.UTF-8/UTF-8"
    #   "de_DE.UTF-8/UTF-8"
    #   "en_GB.UTF-8/UTF-8"
    #   "es_CL.UTF-8/UTF-8"
    #   "fr_FR.UTF-8/UTF-8"
    # ];
  };
}
