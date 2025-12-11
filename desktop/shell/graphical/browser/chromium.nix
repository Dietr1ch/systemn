{ pkgs, lib, ... }:

{
  # https://search.nixos.org/options?channel=unstable&query=programs.chromium
  programs = {
    chromium = {
      enable = true;

      enablePlasmaBrowserIntegration = true;
      defaultSearchProviderSearchURL = lib.mkDefault "https://duckduckgo.com/?q={searchTerms}";

      extensions = [
        "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock origin. https://chromewebstore.google.com/detail/ublock-origin/cjpalhdlnbpafiamejdnhcphjbkeiagm
        "mnjggcdmjocbbbhaepdhchncahnbgone" # SponsorBlock. https://chromewebstore.google.com/detail/sponsorblock-for-youtube/mnjggcdmjocbbbhaepdhchncahnbgone
        "oboonakemofpalcgghocfoadofidjkkk" # KeePassXC. https://chromewebstore.google.com/detail/keepassxc-browser/oboonakemofpalcgghocfoadofidjkkk
        "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark Reader. https://chromewebstore.google.com/detail/dark-reader/eimadpbcbfnmbkopoojfekhnkhdbieeh
        "clngdbkpkpeebahjckkjfobafhncgmne" # Stylus. https://chromewebstore.google.com/detail/stylus/clngdbkpkpeebahjckkjfobafhncgmne
        "ldpochfccmkkmhdbclfhpagapcfdljkj" # Decentraleyes. https://chromewebstore.google.com/detail/decentraleyes/ldpochfccmkkmhdbclfhpagapcfdljkj
        "pkehgijcmpdhfbdbbnkijodmdjhbjlgp" # Privacy Badger. https://chromewebstore.google.com/detail/privacy-badger/pkehgijcmpdhfbdbbnkijodmdjhbjlgp
        "dbepggeogbaibhgnhhndojpepiihcmeb" # Vimium. https://chromewebstore.google.com/detail/vimium/dbepggeogbaibhgnhhndojpepiihcmeb
      ]; # ..programs.chromium.extensions
    }; # ..programs.chromium
  }; # ..programs

  environment = {
    systemPackages = with pkgs; [
      ungoogled-chromium
    ]; # ..environment.systemPackages
  }; # ..environment
}
