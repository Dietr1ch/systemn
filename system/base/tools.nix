{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      killall

      fd
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
