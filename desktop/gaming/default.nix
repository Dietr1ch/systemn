{ pkgs, ... }:

{
  imports = [
    ./comms.nix
    ./gamemode.nix
    ./obs.nix
    ./steam.nix
    # ./wine.nix
  ];

  boot = {
    kernelModules = [
      "hid-nintendo"
    ];
  };

  users = {
    groups = {
      # Users that will play games (Higher limits)
      "games" = {
        gid = 666;
      };
    };
  };

  environment = {
    systemPackages = with pkgs; [
      openvr
    ];

    variables = {
      # https://docs.mesa3d.org/envvars.html#envvar-MESA_VK_WSI_PRESENT_MODE
      # https://docs.vulkan.org/refpages/latest/refpages/source/VkPresentModeKHR.html
      MESA_VK_WSI_PRESENT_MODE = "mailbox";
    };
  };
}
