{ pkgs, ... }:

{
  environment = {
    # Packages in sync with ~/Projects/nixland/programming/web.nix
    systemPackages = with pkgs; [
      static-web-server

      emmet-ls
      htmx-lsp2

      typescript
      typescript-language-server

      vscode-langservers-extracted
      prettier

      wasm-pack
      wasm-bindgen-cli
    ]; # ..environment.systemPackages
  }; # ..environment
}
