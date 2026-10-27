{ pkgs, ... }:

{
  environment = {
    # Packages in sync with ~/Projects/nixland/programming/agentic.nix
    systemPackages = with pkgs; [
      deepseek-harness
      opencode
      snip
    ]; # ..environment.systemPackages
  }; # ..environment
}
