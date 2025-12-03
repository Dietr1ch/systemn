{ pkgs, ... }:

# https://nixos.wiki/wiki/PostgreSQL
{
  environment = {
    # Packages in sync with ~/Projects/nixland/programming/sql.nix
    systemPackages = with pkgs; [
      pgsql-tools
      prqlc
      sql-formatter
    ]; # ..environment.systemPackages
  }; # ..environment
}
