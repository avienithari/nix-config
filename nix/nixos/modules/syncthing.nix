{ config, pkgs, ... }:

{
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    dataDir = "/home/avien";
    group = "users";
    user = "avien";
  };
}
