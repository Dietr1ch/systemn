{ pkgs, ... }:

{
  environment = {
    # Packages in sync with ~/Projects/nixland/programming/rust.nix
    systemPackages = with pkgs; [
      bacon

      rustc
      rust-analyzer
      clippy
      rustfmt
      rust-script

      mold

      cargo
      cargo-audit
      cargo-benchcmp
      cargo-bloat
      cargo-criterion
      cargo-deny
      cargo-edit
      cargo-expand
      cargo-flamegraph
      cargo-fuzz
      cargo-modules
      cargo-nextest
      cargo-outdated
      cargo-pgo
      cargo-public-api
      cargo-semver-checks
      cargo-show-asm
      cargo-spellcheck
      cargo-toml-lint
      cargo-udeps
      # BROKEN: cargo-valgrind # https://github.com/NixOS/nixpkgs/issues/428375
      cargo-watch

      critcmp
    ]; # ..environment.systemPackages
  }; # ..environment
}
