{
  ...
}:

# https://wiki.nixos.org/wiki/WireGuard
{
  networking = {
    # https://search.nixos.org/options?channel=unstable&query=networking.wireguard
    wireguard = {
      enable = true;
    };
  };

  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.wgautomesh
    wgautomesh = {
      enable = true;

      settings = {
        enablePersistence = true;
        enableGossipEncryption = true;
        lan_discovery = true;

        # ../../secrets.nix
        # gossipSecretFile = /var/secrets/wgam-gossip;
        # gossipSecretFile = "??";
        # peers = {
        #   "mate" = {
        #     pubkey = "??";
        #     # Bootstrap
        #     # address = "";
        #     # endpoint = "";
        #   };
        # };
      };
    };

    # prometheus = {
    #   exporters = {
    #     wireguard = {
    #     };
    #   };
    # };
  };

  environment = {
    systemPackages = with pkgs; [
      wireguard-tools
      wireguard-vanity-keygen
    ];
  };
}
