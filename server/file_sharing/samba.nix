{ config, lib, pkgs, ... }:

{
  services = {
    # https://nixos.wiki/wiki/Samba
    samba-wsdd.enable = true; # make shares visible for windows 10 clients
    samba = {
      enable = true;

      # Generates /etc/samba/smb.conf
      settings = {
        global = {
          security = "user";
          workgroup = "WORKGROUP";
          "server string" = "smbnix";
          "netbios name" = "smbnix";
          "use sendfile" = "yes";
          "hosts allow" = "192.168.0. 192.168.1. 127.0.0.1 localhost";
          "hosts deny" = "0.0.0.0/0";
          "guest account" = "nobody";
          "map to guest" = "bad user";
        };

        # ../../secrets.nix
      };
    };
  };

  networking = {
    firewall = {
      allowedTCPPorts = [
        # 139
        445
        5357 # wsdd
      ];
      allowedUDPPorts = [
        # 137
        # 138
        # 139
        445
        3702 # wsdd
      ];
    };
  };

  environment = {
    etc = {
      "avahi/services/samba.service" = {
        mode = "0444";
        text = ''
          <?xml version="1.0" standalone="no"?>
          <!DOCTYPE service-group SYSTEM "avahi-service.dtd">

          <service-group>
            <name replace-wildcards="yes">Samba server at %h</name>
            <service>
              <type>_smb._tcp</type>
              <port>445</port>
            </service>
          </service-group>
        '';
      };
    };
  };
}
