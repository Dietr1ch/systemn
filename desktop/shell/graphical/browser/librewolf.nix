{ pkgs, ... }:

{
  nixpkgs.overlays = [
    (self: super: {
      librewolf = super.librewolf.overrideAttrs (oldAttrs: {
        # Unset the LD_PRELOAD variable to avoid crashes when using a custom system-wide allocator
        postFixup = (oldAttrs.postFixup or "") + ''
          wrapProgram $out/bin/librewolf --unset LD_PRELOAD
        '';
      });
    })
  ];

  programs = {
    firefox = {
      enable = true;

      package = pkgs.librewolf;
    };
  };
}
