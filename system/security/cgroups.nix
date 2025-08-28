{ ... }:

{
  boot = {
    kernelParams = [
      "systemd.unified_cgroup_hierarchy=yes" # Use cgroups v2
      "cgroup_no_v1=all" # Disable cgroups v1
    ];
  };
}
