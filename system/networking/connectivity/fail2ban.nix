{ ... }:

# https://nixos.wiki/wiki/Fail2ban

{
  services = {
    fail2ban = {
      enable = true;

      maxretry = 5;

      ignoreIP = [
        "192.168.0.0/16"
      ];

      bantime = "72h";
      bantime-increment = {
        enable = true;
        maxtime = "14d";
        rndtime = "30m";
      };
    };
  };
}
