{ lib, osConfig, ... }:

{
  home = {
    username = "avien";
    homeDirectory = "/home/avien";
    stateVersion = "26.05";
  };

  imports = [
    ./core
  ] ++ lib.optionals (osConfig.host.class != "server") [
    ./gui
  ];
}
