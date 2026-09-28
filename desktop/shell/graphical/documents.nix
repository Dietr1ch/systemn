{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      typst

      # texliveMinimal
      texliveBasic
      # texliveMedium
    ];
  };
}
