{ lib, vars, ... }:

{
  imports = [
    ./core
  ] ++ lib.optionals (vars.class != "server") [
    ./gui
  ];
}
