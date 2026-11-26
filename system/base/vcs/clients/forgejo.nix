{ pkgs, ... }:

{
  environment = {
    # In sync with ~/Projects/nixland/core/vcs/clients/forgejo.nix
    systemPackages = with pkgs; [
      forgejo-cli
      forgejo-mcp
    ];
  };
}
