{ pkgs, ... }:

{
  programs = {
    # https://search.nixos.org/options?channel=unstable&query=programs.less
    less = {
      enable = true;

      envVariables = {
        # -X --no-init:             Avoids clearing the screen
        # -q --quiet
        # -R --RAW-CONTROL-CHARS:   Keeps colours
        # -F --quit-if-one-screen:  Simply quits printing output if it fits
        #    --mouse
        "LESS" = "-XqRF --mouse";
      };
    };

    # https://search.nixos.org/options?channel=unstable&query=programs.skim
    skim = {
      enable = true;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      killall

      fd
      ripgrep

      # Hashing
      b3sum
      rblake3sum
    ];
  };
}
