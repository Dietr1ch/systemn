{ pkgs, ... }:

{
  # https://search.nixos.org/options?channel=unstable&query=programs.thunderbird
  programs = {
    thunderbird = {
      enable = true;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      telegram-desktop
    ];
  };
}
