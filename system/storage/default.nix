{ pkgs, ... }:

{
  imports = [
    ./fstrim.nix
    ./smartd.nix
  ];

  boot = {
    initrd = {
      checkJournalingFS = true;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      # Monitoring
      iotop

      # Manage
      gptfdisk
      smartmontools
      nvme-cli
    ];
  };
}
