{
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./steam.nix
    ./gamemode.nix
  ];

  boot = {
    kernelModules = [
      "hid-nintendo"
      "v4l2loopback"
    ];
    extraModulePackages = [
      config.boot.kernelPackages.v4l2loopback
    ];
    # v4l2loopback. https://gist.github.com/TheSirC/93130f70cc280cdcdff89faf8d4e98ab
    # https://github.com/umlaeute/v4l2loopback
    #
    # Creates a single loopback on /sys/devices/virtual/video4linux/video9/
    #   exclusive_caps=1 might be needed for Chrome/WebRTC detection
    extraModprobeConfig = ''
      options v4l2loopback exclusive_caps=1 video_nr=9 card_label=loopback_cam
    '';
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
      openvr_git
    ];
  };

}
