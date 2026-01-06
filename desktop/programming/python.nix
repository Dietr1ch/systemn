{ pkgs, ... }:

{
  environment = {
    # Packages in sync with ~/Projects/nixland/programming/python.nix
    systemPackages = with pkgs; [
      (pkgs.python313.withPackages (
        ppkgs: with ppkgs; [
          ipython

          # Tools
          ## Progress bar
          tqdm
          types-tqdm
          ## Type defs
          traittypes
          ## Cache
          joblib

          # Libraries
          ## Plotting
          matplotlib
          ## Numeric
          numpy
          scipy
          tensorflow
          ## Pandas
          pandas
          pandas-stubs
          ## Polars (https://docs.pola.rs/user-guide/installation/)
          polars
          altair
          vega
          vl-convert-python

          # HTTP
          requests

          # Data
          pyarrow
          pydantic
          ## Excel
          fastexcel
          openpyxl
          xlrd

          # Solvers
          z3-solver
        ]
      ))

      # Tools
      ruff # Lint, Formatter
      pylyzer # LSP

      # Solvers
      clingo
      clingcon
      z3
    ]; # ..environment.systemPackages
  }; # ..environment
}
