{ lib, pkgs, ... }:

{
  programs = {
    # NOTE: Deprecated
    # https://search.nixos.org/options?channel=unstable&query=programs.corectrl
    corectrl = {
      enable = true;
    };
  };

  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.scx
    scx = {
      enable = lib.mkDefault false;

      # scheduler = "scx_bpfland";
      # scheduler = "scx_central";
      # scheduler = "scx_flatcg";
      # scheduler = "scx_lavd";
      # scheduler = "scx_layered";
      # scheduler = "scx_nest";
      # scheduler = "scx_pair";
      # scheduler = "scx_qmap";
      # scheduler = "scx_rlfifo";
      # scheduler = "scx_rustland";  # Default
      # scheduler = "scx_rusty";
      # scheduler = "scx_simple";
      # scheduler = "scx_userland";
    };
  };

  environment = {
    # NOTE: cpufrequtils doesn't build on aarch64
    systemPackages = lib.optionals pkgs.stdenv.hostPlatform.isx86_64 [
      pkgs.cpufrequtils
    ];
  };
}
