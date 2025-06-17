{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      killall

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
