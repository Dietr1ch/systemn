{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      killall

      ripgrep
      ## Logs
      less

      # Hashing
      b3sum
      rblake3sum
    ];

    variables = {
      "PAGER" = "less -R";
    };
  };
}
