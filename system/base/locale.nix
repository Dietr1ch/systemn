{ config, lib, pkgs, ... }:

let
  english = "en_GB.UTF-8";
  # french = "fr_FR.UTF-8";
  # german = "de_DE.UTF-8";
  # spanish = "es_CL.UTF-8";
in
{
  i18n = {
    defaultLocale = lib.mkDefault english;

    # ../../secrets.nix
    # NOTE: Has to be in this format: "de_DE.UTF-8/UTF-8"
    # (all others have to be in this format: "de_DE.UTF-8")
    # supportedLocales = [
    #   "de_CH.UTF-8/UTF-8"
    #   "de_DE.UTF-8/UTF-8"

    #   "en_CA.UTF-8/UTF-8"
    #   "en_GB.UTF-8/UTF-8"
    #   "en_US.UTF-8/UTF-8"

    #   "es_CL.UTF-8/UTF-8"

    #   "fr_FR.UTF-8/UTF-8"
    # ];

    extraLocaleSettings = {
      # POSIX
      # -----
      "LC_CTYPE" = lib.mkDefault english;
      "LC_COLLATE" = lib.mkDefault english;
      "LC_MESSAGES" = lib.mkDefault english;
      "LC_MONETARY" = lib.mkDefault english;
      "LC_NUMERIC" = lib.mkDefault english;
      "LC_TIME" = lib.mkDefault english;

      # Non-standard (Supported by glibc 2.2)
      # ------------
      "LC_ADDRESS" = lib.mkDefault english;
      "LC_IDENTIFICATION" = lib.mkDefault english;
      "LC_MEASUREMENT" = lib.mkDefault english;
      "LC_NAME" = lib.mkDefault english;
      "LC_PAPER" = lib.mkDefault english;
      "LC_TELEPHONE" = lib.mkDefault english;
    };
  };
}
