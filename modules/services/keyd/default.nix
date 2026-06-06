{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    keyd
  ];

  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          main = {
            capslock = "esc";
            leftalt = lib.mkIf (!config.host.feature.useZsa) "rightalt";
          };
        };
      };
    };
  };
}
