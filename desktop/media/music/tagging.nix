{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      # beets
      # picard
      wrtag
    ]; # ..environment.systemPackages
  }; # ..environment
}
