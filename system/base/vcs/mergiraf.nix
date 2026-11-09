{ pkgs, ... }:

{
  environment = {
    etc = {
      # /etc/gitattributes
      gitattributes = {
        text = ''
          # System-level attributes
          # Created from ~/Projects/systemn/system/base/vcs/git.nix

          # Mergiraf
          # https://mergiraf.org/usage.html#registration-as-a-git-merge-driver
          # mergiraf languages --gitattributes
          *.c merge=mergiraf
          *.c++ merge=mergiraf
          *.cc merge=mergiraf
          *.cpp merge=mergiraf
          *.cppm merge=mergiraf
          *.cs merge=mergiraf
          *.cxx merge=mergiraf
          *.dart merge=mergiraf
          *.dts merge=mergiraf
          *.go merge=mergiraf
          *.h merge=mergiraf
          *.h++ merge=mergiraf
          *.hcl merge=mergiraf
          *.hh merge=mergiraf
          *.hpp merge=mergiraf
          *.htm merge=mergiraf
          *.html merge=mergiraf
          *.hxx merge=mergiraf
          *.ini merge=mergiraf
          *.ixx merge=mergiraf
          *.java merge=mergiraf
          *.js merge=mergiraf
          *.json merge=mergiraf
          *.jsx merge=mergiraf
          *.kt merge=mergiraf
          *.lua merge=mergiraf
          *.md merge=mergiraf
          *.mjs merge=mergiraf
          *.mpp merge=mergiraf
          *.nix merge=mergiraf
          *.php merge=mergiraf
          *.phtml merge=mergiraf
          *.properties merge=mergiraf
          *.py merge=mergiraf
          *.rb merge=mergiraf
          *.rs merge=mergiraf
          *.sbt merge=mergiraf
          *.scala merge=mergiraf
          *.sol merge=mergiraf
          *.sv merge=mergiraf
          *.svh merge=mergiraf
          *.tcc merge=mergiraf
          *.tf merge=mergiraf
          *.tfvars merge=mergiraf
          *.toml merge=mergiraf
          *.ts merge=mergiraf
          *.tsx merge=mergiraf
          *.xhtml merge=mergiraf
          *.xml merge=mergiraf
          *.yaml merge=mergiraf
          *.yml merge=mergiraf
          * merge=mergiraf
        '';
        mode = "0444";
      }; # ..environment.etc.gitattributes
    }; # ..environment.etc
    systemPackages = with pkgs; [
      mergiraf
    ]; # ..environment.systemPackages
  }; # ..environment
}
