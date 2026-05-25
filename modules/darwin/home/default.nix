{ lib, username, ... }:

{
  imports = [
    ../../home/core
  ];

  programs = {
    direnv.enable = lib.mkForce false;
    git.enable = lib.mkForce false;
    ssh.enable = lib.mkForce false;
  };

  home = {
    inherit username;
    stateVersion = "26.05";
  };
}
