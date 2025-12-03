{ pkgs, ... }:

{
  environment = {
    # Packages in sync with ~/Projects/nixland/programming/python.nix
    systemPackages = with pkgs; [
      (pkgs.python313.withPackages (
        ppkgs: with ppkgs; [
          ipython

          tqdm
          types-tqdm

          numpy
          scipy
          tensorflow

          pandas
          pandas-stubs

          polars
          altair
          vega
          vl-convert-python

          traittypes

          matplotlib

          requests
          xlrd

          z3-solver
        ]
      ))

      # Tools
      ruff # Lint, Formatter
      pylyzer # LSP
    ]; # ..environment.systemPackages
  }; # ..environment
}
