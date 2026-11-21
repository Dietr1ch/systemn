{ ... }:

{
  imports = [
    ./connectivity # connectivity/default.nix

    ./information.nix
    ./firewall.nix
    ./tools.nix
  ];

  boot = {
    kernel = {
      sysctl = {
        # Performance (https://wiki.archlinux.org/title/Sysctl#Improving_performance)
        # -----------
        # https://wiki.archlinux.org/title/Sysctl#Increasing_the_size_of_the_receive_queue
        "net.core.netdev_max_backlog" = 16384;

        # https://wiki.archlinux.org/title/Sysctl#Increase_the_maximum_connections
        "net.core.somaxconn" = 8192;

        # https://wiki.archlinux.org/title/Sysctl#Increase_the_memory_dedicated_to_the_network_interfaces
        # NOTE: This sections appeors to be tuning for 40Gbps interfaces, which are uncommon
        # "net.core.rmem_default" = 1048576;
        # "net.core.rmem_max" = 16777216;
        # "net.core.wmem_default" = 1048576;
        # "net.core.wmem_max" = 16777216;
        # "net.core.optmem_max" = 65536;
        # "net.ipv4.tcp_rmem" = "4096 1048576 2097152";
        # "net.ipv4.tcp_wmem" = "4096 65536 16777216";
        # # Also bump UDP memory limits
        # "net.ipv4.udp_rmem_min" = 8192;
        # "net.ipv4.udp_wmem_min" = 8192;

        # https://wiki.archlinux.org/title/Sysctl#Enable_TCP_Fast_Open
        "net.ipv4.tcp_fastopen" = 3;

        # https://wiki.archlinux.org/title/Sysctl#Tweak_the_pending_connection_handling
        "net.ipv4.tcp_max_syn_backlog" = 8192;
        "net.ipv4.tcp_max_tw_buckets" = 2000000;
        "net.ipv4.tcp_tw_reuse" = 1; # 1: enable for all connections | 2: enable for loopback
        "net.ipv4.tcp_fin_timeout" = 10;
        "net.ipv4.tcp_slow_start_after_idle" = 0;

        # https://wiki.archlinux.org/title/Sysctl#Change_TCP_keepalive_parameters
        "net.ipv4.tcp_keepalive_time" = 60;
        "net.ipv4.tcp_keepalive_intvl" = 10;
        "net.ipv4.tcp_keepalive_probes" = 6;

        # https://wiki.archlinux.org/title/Sysctl#Enable_MTU_probing
        "net.ipv4.tcp_mtu_probing" = 1;
        "net.ipv4.tcp_mtu_probe_floor" = 1024;

        # https://wiki.archlinux.org/title/Sysctl#TCP_timestamps
        # "net.ipv4.tcp_timestamps" = 0;

        # https://wiki.archlinux.org/title/Sysctl#TCP_Selective_Acknowledgement
        # NOTE: Geared towards high latency connections
        # "net.ipv4.tcp_sack" = 1;

        # https://wiki.archlinux.org/title/Sysctl#Enable_BBR
        # https://en.wikipedia.org/wiki/TCP_congestion_control#TCP_BBR
        "net.core.default_qdisc" = "cake";
        "net.ipv4.tcp_congestion_control" = "bbr";

        # https://wiki.archlinux.org/title/Sysctl#Increase_the_Ephemeral_port_range
        "net.ipv4.ip_local_port_range" = "30000 65535";
      };
    };
  };

  # https://search.nixos.org/options?channel=unstable&query=networking
  networking = {
    # https://nixos.wiki/wiki/Systemd-networkd
    # useNetworkd = true;

    # https://search.nixos.org/options?channel=unstable&query=networking.networkmanager
    networkmanager = {
      ethernet = {
        macAddress = "random";
      };
      wifi = {
        macAddress = "random";
        scanRandMacAddress = true;
      };
    };
    dhcpcd = {
      enable = true;

      wait = "background";

      extraConfig = ''
        noarp  # Avoid checking if the IP is taken
      '';
    };
  };
}
