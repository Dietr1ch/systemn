{ lib, pkgs, ... }:

{
  programs = {
    # NOTE: Deprecated
    # https://search.nixos.org/options?channel=unstable&query=programs.corectrl
    corectrl = {
      enable = true;
    }; # ..programs.corectrl
  }; # ..programs

  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.scx-loader
    scx-loader = {
      enable = true;

      schedsPackages = with pkgs.scx; [
        full # include rustscheds & cscheds
      ]; # ..services.scx-loader.schedPackages

      # https://github.com/sched-ext/scx-loader/blob/main/crates/scx_loader/configuration.md
      config = {
        default_sched = null;
        default_mode = "Auto";

        # scheds = {
        #   "SCHED" = {
        #     auto_mode = {
        #     };
        #     gaming_mode = {
        #     };
        #     lowlatency_mode = {
        #     };
        #     powersave_mode = {
        #     };
        #     server_mode = {
        #     };
        #   }; # ..services.scx-loader.config.scheds."SCHED"
        # }; # ..services.scx-loader.config.scheds
      }; # ..services.scx-loader.config
    }; # ..services.scx-loader
  }; # ..services

  environment = {
    # NOTE: cpufrequtils doesn't build on aarch64
    systemPackages = lib.optionals pkgs.stdenv.hostPlatform.isx86_64 [
      pkgs.cpufrequtils
      ]; # ..environment.systemPackages
  }; # ..environment
}
