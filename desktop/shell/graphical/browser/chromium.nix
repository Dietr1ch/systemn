{ ... }:

{
  programs = {
    chromium = {
      enable = true;

      defaultSearchProviderSearchURL = "https://duckduckgo.com/?q={searchTerms}";
    };
  };
}
