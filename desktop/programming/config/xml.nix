{ pkgs, ... }:

{
  environment = {
    # Packages in sync with ~/Projects/nixland/programming/config/xml.nix
    systemPackages = with pkgs; [
      opensp # onsgmls
      xq-xml # jq, but for xml
    ]; # ..environment.systemPackages
  }; # ..environment
}
