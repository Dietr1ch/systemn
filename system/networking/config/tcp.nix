{ ... }:

# https://cromwell-intl.com/open-source/performance-tuning/tcp.html
{
  boot = {
    kernel = {
      sysctl = {
        # Performance (https://wiki.archlinux.org/title/Sysctl#Improving_performance)
        # -----------

        # Bump buffer sizes
        # https://wiki.archlinux.org/title/Sysctl#Increase_the_memory_dedicated_to_the_network_interfaces
        # Net (https://github.com/rf11291/magicTCP#tuning-tcp-via-sysctlconf)
        # 2.5 Gbps * 200ms ≈ 62.5 MB  (2.5Gb/s link needs 64MB on a transfer with 0.2048s latency)
        "net.ipv4.tcp_rmem" =
          let
            kB = 1024;
            MB = 1024 * kB;

            min = 8 * kB; # 8kB
            def = 256 * kB; # 256kB
            max = 128 * MB; # 128MB
          in
          "${toString min} ${toString def} ${toString max}";

        "net.ipv4.tcp_wmem" =
          let
            kB = 1024;
            MB = 1024;

            min = 8 * kB; # 8kB
            def = 256 * kB; # 256kB
            max = 128 * MB; # 128MB
          in
          "${toString min} ${toString def} ${toString max}";

        # https://wiki.archlinux.org/title/Sysctl#Enable_TCP_Fast_Open
        "net.ipv4.tcp_fastopen" = 3;

        # https://wiki.archlinux.org/title/Sysctl#Tweak_the_pending_connection_handling
        "net.ipv4.tcp_max_syn_backlog" = 8 * 1024;
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
        "net.ipv4.tcp_congestion_control" = "bbr";

        # Net (https://github.com/nexstorm/magicTCP)
        "net.ipv4.tcp_adv_win_scale" = -2;
        "net.ipv4.tcp_collapse_max_bytes" = 6291456;
        "net.ipv4.tcp_notsent_lowat" = 131072;
        "net.ipv4.tcp_window_scaling" = 1;
      }; # ..boot.kernel.sysctl
    }; # ..boot.kernel
  }; # ..boot
}
