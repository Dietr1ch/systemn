{ ... }:

{
  programs = {
    # https://search.nixos.org/options?channel=unstable&query=programs.steam
    steam = {
      enable = true;

      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;

      protontricks.enable = true;
    };
  };

  # Peripherals
  # ===========
  hardware = {
    steam-hardware = {
      enable = true;
    };
  };

  environment = {
    sessionVariables = {
      "PROTON_ENABLE_WAYLAND" = "1";
    };
  };
}
