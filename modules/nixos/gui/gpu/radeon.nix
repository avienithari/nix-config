{ config, lib, ... }:

{
  config = lib.mkIf (config.host.isGuiHost && config.host.gpu == "radeon") {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    services.xserver.videoDrivers = [ "amdgpu" ];
    programs.xwayland.enable = true;
  };
}
