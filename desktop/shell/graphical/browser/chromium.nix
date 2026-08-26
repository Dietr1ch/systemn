{ pkgs, lib, ... }:

{
  nixpkgs.overlays = [
    (self: super: {
      ungoogled-chromium = super.ungoogled-chromium.overrideAttrs (oldAttrs: {
        # Unset the LD_PRELOAD variable to avoid crashes when using a custom system-wide allocator
        postFixup = (oldAttrs.postFixup or "") + ''
          wrapProgram $out/bin/chromium --unset LD_PRELOAD
        '';
      });
    })
  ];

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
      captive-browser
      ungoogled-chromium
    ]; # ..environment.systemPackages
  }; # ..environment
}
