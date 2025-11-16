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
  hardware = {
    steam-hardware = {
      enable = true;
    };
  };
}
