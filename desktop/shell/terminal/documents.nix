{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      (pkgs.mermaid-cli.override {
        chromium = ungoogled-chromium;
      })
      pandoc
    ];
  };
}
