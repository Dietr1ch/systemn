{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      jujutsu

      jjui
      lazyjj
    ];
  };
}
