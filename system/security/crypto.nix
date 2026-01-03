{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      age
      age-plugin-openpgp-card

      openpgp-card-tools
    ];
  };
}
