{ ... }:

{
  services = {
    ipfs = {
      enable = true;

      autoMount = true;
      startWhenNeeded = true;
      enableGC = true;
    };
  };
}
