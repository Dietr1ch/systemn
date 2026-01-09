{ pkgs, ... }:

# https://nixos.wiki/wiki/AMD_GPU
# https://docs.mesa3d.org/drivers/radv.html
# https://www.protondb.com/help/improving-performance
# https://ritze03.github.io/cs2-linux-optimization/guide.html
{
  environment = {
    systemPackages = with pkgs; [
      amdgpu_top
    ];

    variables = {
      "AMD_USERQ" = "1"; # https://docs.kernel.org/next/gpu/amdgpu/userq.html
      "RADV_PERFTEST" = "aco"; # NOTE: Default since Mesa 20.2 (https://github.com/doitsujin/dxvk/issues/1905)
    };
  };
}
