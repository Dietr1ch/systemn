{ pkgs, ... }:

{
  environment = {
    # Packages in sync with ~/Projects/nixland/programming/databases.nix
    systemPackages = with pkgs; [
      # Prolog
      swi-prolog-gui

      # SQL
      sqruff

      # Postgres
      postgres-language-server

      # DuckDB
      duckdb
    ]; # ..environment.systemPackages
  }; # ..environment
}
