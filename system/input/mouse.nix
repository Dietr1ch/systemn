{ ... }:

{
  services = {
    libinput = {
      enable = true;

      # https://search.nixos.org/options?channel=unstable&query=services.libinput.mouse
      mouse = {
        accelProfile = "flat";
        accelSpeed = "0.0";

        naturalScrolling = false;

        disableWhileTyping = false;
      };
    };
  };
}
