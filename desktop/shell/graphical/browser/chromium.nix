{ lib, ... }:

{
  # https://search.nixos.org/options?channel=unstable&query=programs.chromium
  programs = {
    chromium = {
      enable = true;

      enablePlasmaBrowserIntegration = true;
      defaultSearchProviderSearchURL = lib.mkDefault "https://duckduckgo.com/?q={searchTerms}";
    };
  };
}
