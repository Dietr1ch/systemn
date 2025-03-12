{ ... }:

{
  programs = {
    # https://search.nixos.org/options?channel=unstable&query=programs.steam
    steam = {
      enable = true;

      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };
  };

  # Peripherals
  # ===========
  # https://discourse.nixos.org/t/thinkpad-t470s-power-management/8141/2
  hardware = {
    steam-hardware = {
      enable = true;
    };
  };
}
