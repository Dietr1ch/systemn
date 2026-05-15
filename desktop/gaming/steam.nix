{ pkgs, ... }:

{
  programs = {
    # https://search.nixos.org/options?channel=unstable&query=programs.steam
    steam = {
      enable = true;

      # https://search.nixos.org/options?channel=unstable&query=programs.steam.gamescopeSession
      gamescopeSession = {
        enable = true;

        # args = [ ];
        # env = { };
        # steamArgs = [
        #   "-tenfoot"
        #   "-pipewire-dmabuf"
        # ];
      };

      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;

      protontricks.enable = true;
    }; # ..programs.steam
  }; # ..programs

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
      "PROTON_USE_DXVK" = "1";
    }; # ..environment.sessionVariables

    systemPackages = with pkgs; [
      protonup-qt
    ]; # ..environment.systemPackages
  }; # ..environment
}
