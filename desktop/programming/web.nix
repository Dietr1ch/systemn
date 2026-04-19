{ pkgs, ... }:

{
  environment = {
    # Packages in sync with ~/Projects/nixland/programming/web.nix
    systemPackages = with pkgs; [
      # Servers
      static-web-server

      # Formatters
      prettier

      # Optimisers
      closurecompiler
      subfont

      # Language servers
      emmet-ls
      htmx-lsp2
      vscode-langservers-extracted

      # Tools
      wasm-pack
      wasm-bindgen-cli
    ]; # ..environment.systemPackages
  }; # ..environment
}
