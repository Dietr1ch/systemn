{ ... }:

{
  boot = {
    kernel = {
      sysctl = {
        # Performance (https://wiki.archlinux.org/title/Sysctl#Improving_performance)
        # -----------

        # Bump buffer sizes
        # https://wiki.archlinux.org/title/Sysctl#Increase_the_memory_dedicated_to_the_network_interfaces
        # https://gilbertasm.github.io/2018/09/13/tunning-udp-buffers.html
        # NOTE: min UDP r/w mem defaults to 4kB
        # 1.0 Gbps * 200ms ≈ 25.6 MB  (1.0Gb/s link needs 25MB on a transfer with 0.2s latency)
        # 2.5 Gbps * 200ms ≈ 62.5 MB  (2.5Gb/s link needs 64MB on a transfer with 0.2048s latency)
        "net.ipv4.udp_rmem_min" = 256 * 1024; # 256kB
        "net.ipv4.udp_wmem_min" = 256 * 1024; # 256kB
      }; # ..boot.kernel.sysctl
    }; # ..boot.kernel
  }; # ..boot
}
