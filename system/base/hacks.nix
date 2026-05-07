{ ... }:

{
  nixpkgs = {
    overlays = [
      (_: prev: {

        # 2026-05-07: OpenLDAP
        # https://github.com/NixOS/nixpkgs/issues/514113
        openldap = prev.openldap.overrideAttrs {
          doCheck = false;
        };

      })
    ];
  };
}
