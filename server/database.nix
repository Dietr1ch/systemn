{ config, lib, pkgs, ... }:

{
  services = {
    # https://nixos.wiki/wiki/PostgreSQL
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
    };
  };
}
