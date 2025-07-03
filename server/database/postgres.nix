{ lib, pkgs, ... }:

# https://nixos.wiki/wiki/PostgreSQL
{
  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.postgresql
    postgresql = {
      enable = true;

      enableJIT = true;
      ensureDatabases = [
        "scratch"
      ];

      authentication = lib.mkOverride 10 ''
        #type database dbUser authMethod
        local all      all    trust
      '';
      identMap = ''
        # ArbitraryMapName systemUser dbUser
        superuser_map      root       postgres
        superuser_map      postgres   postgres

        # Let other names login as themselves
        superuser_map      /^(.*)$    \1
      '';

      # https://search.nixos.org/packages?channel=unstable&query=postgresql17Packages
      #
      # Extensions here become available to Databases, but must be enabled
      # per-database.
      #
      # Listing available extensions,
      #   psql $DATABASE --command 'select * from pg_available_extensions'
      # Listing enabled extensions,
      #   psql $DATABASE --command 'select * from pg_extension'
      # Adding extensions to DB,
      #   sudo --user postgres psql $DATABASE --command 'create extension $EXTENSION'
      extensions = with pkgs.postgresqlPackages; [
        pg_cron    # Cron jobs
        pg_hll     # Hyper-log-log
        pg_uuidv7  # UUIDv7
        pgsodium   # libsodium crypto
        pgtap      # Unit testing
        pgvector   # Vector search
        postgis    # GIS
      ];
    };
  };
}
