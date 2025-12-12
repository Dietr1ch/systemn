{ pkgs, ... }:

{
  environment = {
    # Packages in sync with ~/Projects/nixland/programming/web.nix
    systemPackages = with pkgs; [
      emmet-ls

      vscode-langservers-extracted
      prettier

      wasm-pack
      wasm-bindgen-cli
    ]; # ..environment.systemPackages
  }; # ..environment
}
