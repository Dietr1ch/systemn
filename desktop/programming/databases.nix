{ pkgs, ... }:

{
  environment = {
    # Packages in sync with ~/Projects/nixland/programming/databases.nix
    systemPackages = with pkgs; [
      # Prolog
      swi-prolog-gui

      # SQL
      sqruff
      pgsql-tools
      prqlc
      sql-formatter

      # Postgres
      postgres-language-server

      # DuckDB
      duckdb
    ]; # ..environment.systemPackages
  }; # ..environment
}
