{ pkgs, ... }:

{
  environment = {
    # Packages in sync with ~/Projects/nixland/programming/databases.nix
    systemPackages = with pkgs; [
      # SQL
      sqruff

      # Postgres
      postgres-language-server

      # DuckDB
      duckdb
    ]; # ..environment.systemPackages
  }; # ..environment
}
