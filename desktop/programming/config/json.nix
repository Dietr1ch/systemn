{ pkgs, ... }:

{
  environment = {
    # Packages in sync with ~/Projects/nixland/programming/config/json.nix
    systemPackages = with pkgs; [
      jq
      jqp
    ]; # ..environment.systemPackages
  }; # ..environment
}
