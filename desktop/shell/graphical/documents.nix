{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      # texliveMinimal
      texliveBasic
      # texliveMedium
    ];
  };
}
