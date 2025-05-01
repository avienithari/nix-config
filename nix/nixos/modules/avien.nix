{ config, pkgs, ... }:

{
  users.users.avien = {
    shell = pkgs.zsh;
    extraGroups = [ "audio" ];
  };

  programs.zsh.enable = true;
}
