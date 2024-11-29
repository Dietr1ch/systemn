{ lib, pkgs, ... }:

# https://nixos.wiki/wiki/PostgreSQL
{
  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.postgresql
    postgresql = {
      enable = true;

      ensureDatabases = [
        "scratch"
      ];

      authentication = pkgs.lib.mkOverride 10 ''
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
