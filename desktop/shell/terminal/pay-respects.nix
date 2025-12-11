{ ... }:

{
  programs = {
    # https://search.nixos.org/options?channel=unstable&query=programs.pay-respects
    pay-respects = {
      enable = true;
    };
  };

  environment = {
    variables = {
      # NOTE: Ensure this nix is the default package manager. (https://codeberg.org/iff/pay-respects/issues/34)
      "_PR_PACKAGE_MANAGER" = "nix";
    };
  };
}
