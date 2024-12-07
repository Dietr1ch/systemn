{ ... }:

{
  services = {
    libinput = {
      enable = true;

      # https://search.nixos.org/options?channel=unstable&query=services.libinput.touchpad
      touchpad = {
        accelProfile = "adaptive";

        naturalScrolling = true;
        horizontalScrolling = true;

        tapping = true;
        middleEmulation = true;

        disableWhileTyping = true;
      };
    };
  };
}
