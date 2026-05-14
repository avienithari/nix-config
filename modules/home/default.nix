{ lib, osConfig, ... }:

{
  home.username = "avien";
  home.homeDirectory = "/home/avien";
  home.stateVersion = "26.05";

  imports = [
    ./core
  ] ++ lib.optionals (osConfig.host.class != "server") [
    ./gui
  ];
}
