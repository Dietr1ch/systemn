{ pkgs, ... }:

{
  environment = {
    # In sync with ~/Projects/nixland/core/vcs/clients/github.nix
    systemPackages = with pkgs; [
      github-cli
      github-mcp-server
    ];
  };
}
