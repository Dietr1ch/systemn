{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      # broot  # NOTE: This brings in llvm, rustc, cargo. Not worth compiling for nixos-unstable
      ripgrep
      ## Logs
      less

      ## Version Control
      git
    ];

    variables = {
      "PAGER" = "less -R";
    };
  };
}
