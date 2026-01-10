{ ... }:

{
  services = {
    # https://nixos.wiki/wiki/NFS
    nfs = {
      server = {
        enable = true;

        # ../../secrets.nix
        # exports = ''
        #   /Shares  192.168.0.0/16(insecure,no_subtree_check,crossmnt,fsid=0)
        # '';

        # Fix ports for NFSv3
        statdPort = 4000;
        lockdPort = 4001;
        mountdPort = 4002;
      };
    }; # ..services.nfs
  }; # ..services

  networking = {
    firewall = {
      # https://serverfault.com/questions/377170/which-ports-do-i-need-to-open-in-the-firewall-to-use-nfs
      allowedTCPPorts = [
        111 # Portmapper
        2049 # NFS
      ];
      allowedTCPPortRanges = [
        {
          from = 4000;
          to = 4002;
        }
      ];

      allowedUDPPorts = [
        111 # Portmapper
        2049 # NFS
      ];
      allowedUDPPortRanges = [
        {
          from = 4000;
          to = 4002;
        }
      ];
    }; # ..networking.firewall
  }; # ..networking

  environment = {
    etc = {

      "avahi/services/nfs.service" = {
        mode = "0444";
        text = ''
          <?xml version="1.0" standalone="no"?>
          <!DOCTYPE service-group SYSTEM "avahi-service.dtd">

          <service-group>
            <name replace-wildcards="yes">NFS server at %h</name>
            <service>
              <type>_nfs._tcp</type>
              <port>2049</port>
              <txt-record>path=/Shares</txt-record>
            </service>
          </service-group>
        '';
      };

    }; # ..environment.etc
  }; # ..environment
}
