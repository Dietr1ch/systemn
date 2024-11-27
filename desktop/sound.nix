{ ... }:

{
  security.rtkit.enable = true;

  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.pipewire
    pipewire = {
      enable = true;

      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;

      wireplumber = {
        enable = true;
        extraLv2Packages = with pkgs; [
          lsp-plugins  # https://search.nixos.org/packages?channel=unstable&query=lsp-plugins
        ];
      };
    };
  };
}
