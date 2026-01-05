{ pkgs, ... }:

{
  programs = {
    # https://search.nixos.org/options?channel=unstable&query=programs.less
    less = {
      enable = true;

      envVariables = {
        # -X --no-init:             Avoids clearing the screen
        # -q --quiet
        # -R --RAW-CONTROL-CHARS:   Keeps colours
        # -F --quit-if-one-screen:  Simply quits printing output if it fits
        #    --mouse
        "LESS" = "-XqRF --mouse";
      };
    };

    # https://search.nixos.org/options?channel=unstable&query=programs.skim
    skim = {
      enable = true;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      killall

      fd
      ripgrep

      # Disk (Also in ://system/storage/default.nix)
      dua
      ncdu

      parallel-full

      # Hashing
      b3sum
      rblake3sum

      # Performance
      perf
      pprof
      perf_data_converter

      # Crisis tools
      # https://www.brendangregg.com/blog/2024-03-24/linux-crisis-tools.html
      procps
      util-linux
      sysstat
      iproute2
      numactl
      tcpdump
      perf
      bpftrace
      trace-cmd
      nicstat
      ethtool
      tiptop
      cpuid
      msr-tools
      # More
      ptcpdump
      bpftools
    ];
  };
}
