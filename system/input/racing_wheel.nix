{ pkgs, ... }:

{
  hardware = {
    new-lg4ff = {
      enable = true;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      oversteer
    ];
  };
}
