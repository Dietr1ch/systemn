{ lib, ... }:

# https://nixos.wiki/wiki/Polkit
# https://search.nixos.org/options?channel=unstable&query=security.polkit
{
  security = {
    # https://search.nixos.org/options?channel=unstable&query=security.polkit
    polkit = {
      enable = true;

      debug = lib.mkDefault true;

      # https://www.freedesktop.org/software/polkit/docs/latest/polkit.8.html#polkit-rules
      # - /etc/polkit-1/rules.d/
      #   - /etc/polkit-1/rules.d/10-nixos.rules
      # - /usr/share/polkit-1/rules.d/
      extraConfig = ''
        /*
           SystemN's extraConfig
        */

        /* Log authorization checks. */
        polkit.addRule(function(action, subject) {
          if (action.id == "org.freedesktop.policykit.exec") {
            polkit.log("Exec: action=" + action, ". subject=" + subject);
          } else {
            polkit.log("Action: action=" + action, ". subject=" + subject);
          }
        });
      '';
    };
  };
}
