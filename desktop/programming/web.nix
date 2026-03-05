{ pkgs, ... }:

{
  environment = {
    # Packages in sync with ~/Projects/nixland/programming/web.nix
    systemPackages = with pkgs; [
      static-web-server
      closurecompiler

      emmet-ls
      htmx-lsp2

      vscode-langservers-extracted
      prettier

      wasm-pack
      wasm-bindgen-cli
    ]; # ..environment.systemPackages
  }; # ..environment
}
