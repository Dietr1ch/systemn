{
  config,
  pkgs,
  lib,
  ...
}:

# https://docs.i2pd.website/en/latest/
{
  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.i2pd
    # ~/Projects/nixpkgs/nixos/modules/services/networking/i2pd.nix
    i2pd = {
      enable = true;

      # https://search.nixos.org/options?channel=unstable&query=services.i2pd.ssu2
      ssu2 = {
        enable = true;
      };
      # https://search.nixos.org/options?channel=unstable&query=services.i2pd.ssu
      ssu.enable = lib.mkForce false;

      # https://search.nixos.org/options?channel=unstable&query=services.i2pd.upnp
      # upnp = {
      #   enable = true;
      # };
      # https://search.nixos.org/options?channel=unstable&query=services.i2pd.websocket
      # websocket = {
      #   enable = true;
      #   port = lib.mkDefault 7666;
      # };

      # https://search.nixos.org/options?channel=unstable&query=services.i2pd.proto.*.enable
      proto = {
        # # https://search.nixos.org/options?channel=unstable&query=services.i2pd.proto.http
        # http = {
        #   enable = true;
        #   port = lib.mkDefault 7070;
        # };

        # # https://search.nixos.org/options?channel=unstable&query=services.i2pd.proto.httpProxy
        # httpProxy = {
        #   enable = true;
        #   port = lib.mkDefault 4444;
        # };

        # # https://search.nixos.org/options?channel=unstable&query=services.i2pd.proto.i2cp
        # https://geti2p.net/en/docs/protocol/i2cp
        # i2cp = {
        #   enable = true;
        #   port = lib.mkDefault 7654;
        # };

        # # https://search.nixos.org/options?channel=unstable&query=services.i2pd.proto.socksProxy
        # socksProxy = {
        #   enable = lib.mkDefault false;
        #   port = lib.mkDefault 4447;
        # };

        # https://search.nixos.org/options?channel=unstable&query=services.i2pd.proto.sam
        # https://geti2p.net/en/docs/api/samv3
        sam = {
          enable = true;
          port = lib.mkDefault 7656;
        };

        # BOB (DEPRECATED)
        # https://geti2p.net/en/docs/api/bob
        bob.enable = lib.mkForce false;

        # # https://search.nixos.org/options?channel=unstable&query=services.i2pd.proto.i2pControl
        # i2pControl = {
        #   enable = true;
        #   port = lib.mkDefault 7650;
        # };
      };

      # https://search.nixos.org/options?channel=unstable&query=services.i2pd.yggdrasil
      yggdrasil = {
        enable = config.services.yggdrasil.enable;
      };
    };
  };

  environment = {
    systemPackages = with pkgs; [
      i2pd-tools
    ];
  };
}
