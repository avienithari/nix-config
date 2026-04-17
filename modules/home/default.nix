{ lib, vars, ... }:

{
  home.username = "avien";
  home.homeDirectory = "/home/avien";
  home.stateVersion = "26.05";

  imports = [
    ./core
  ] ++ lib.optionals (vars.class != "server") [
    ./gui
  ];
}
