{ ... }:

{
  imports = [
    ./tcp.nix
    ./udp.nix
  ];

  boot = {
    kernel = {
      sysctl = {

        # Performance (https://wiki.archlinux.org/title/Sysctl#Improving_performance)
        # -----------
        # https://wiki.archlinux.org/title/Sysctl#Increasing_the_size_of_the_receive_queue
        "net.core.netdev_max_backlog" = 16 * 1024;

        # https://wiki.archlinux.org/title/Sysctl#Increase_the_maximum_connections
        "net.core.somaxconn" = 8 * 1024;

        # https://wiki.archlinux.org/title/Sysctl#Increase_the_memory_dedicated_to_the_network_interfaces
        # NOTE: This article appears to be tuning for 40Gbps interfaces, which are uncommon
        # 1.0 Gbps * 200ms ≈ 25.6 MB  (1.0Gb/s link needs 25MB on a transfer with 0.2s latency)
        # 2.5 Gbps * 200ms ≈ 62.5 MB  (2.5Gb/s link needs 64MB on a transfer with 0.2048s latency)

        "net.core.rmem_default" = 1 * 1024 * 1024; # 1MB
        "net.core.rmem_max" = 256 * 1024 * 1024; # 256MB

        "net.core.wmem_default" = 1 * 1024 * 1024; # 1MB
        "net.core.wmem_max" = 256 * 1024 * 1024; # 256MB
        # "net.core.optmem_max" = 64 * 1024;

        # https://wiki.archlinux.org/title/Sysctl#Enable_BBR
        # https://en.wikipedia.org/wiki/TCP_congestion_control#TCP_BBR
        "net.core.default_qdisc" = "cake";

        # https://wiki.archlinux.org/title/Sysctl#Increase_the_Ephemeral_port_range
        "net.ipv4.ip_local_port_range" = "30000 65535";
      }; # ..boot.kernel.sysctl
    }; # ..boot.kernel
  }; # ..boot
}
