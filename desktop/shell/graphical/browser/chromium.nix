{ pkgs, lib, ... }:

{
  # https://search.nixos.org/options?channel=unstable&query=programs.chromium
  programs = {
    chromium = {
      enable = true;

      enablePlasmaBrowserIntegration = true;
      defaultSearchProviderSearchURL = lib.mkDefault "https://duckduckgo.com/?q={searchTerms}";
    }; # ..programs.chromium
  }; # ..programs

  environment = {
    systemPackages = with pkgs; [
      ungoogled-chromium
    ]; # ..environment.systemPackages
  }; # ..environment
}
