{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      broot
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
