{ lib, ... }:

{
  boot = {
    # Custom kernel build configuration
    # https://search.nixos.org/options?channel=unstable&query=boot.kernelPatches
    kernelPatches = [
      {
        name = "rt";
        patch = null;
        structuredExtraConfig = with lib.kernel; {
          "PREEMPT_RT" = yes;
          "PREEMPT" = lib.mkForce yes;

          # Unused options
          "PREEMPT_VOLUNTARY" = lib.mkForce unset;
          "PREEMPT_FULL" = lib.mkForce unset;
          "DRM_I915_GVT" = lib.mkForce unset;
          "DRM_I915_GVT_KVMGT" = lib.mkForce unset;

          # Other options that I apperently need to set
          "RUST_BUILD_ASSERT_ALLOW" = lib.mkForce no;
          "RUST_DEBUG_ASSERTIONS" = lib.mkForce no;
          "RUST_OVERFLOW_CHECKS" = lib.mkForce no;
        };
      }
    ]; # ..boot.kernelPatches
  }; # ..boot
}
