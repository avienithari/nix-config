{ config, pkgs, ... }:

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
            leftalt = "rightalt";
          };
        };
      };
    };
  };
}
