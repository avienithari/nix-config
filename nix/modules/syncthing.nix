{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    syncthing
  ];

  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    dataDir = "/home/avien";
    group = "users";
    user = "avien";
  };
}
