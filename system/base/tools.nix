{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      broot
      ripgrep
      ## Logs
      less
    ];

    variables = {
      "PAGER" = "less -R";
    };
  };
}
