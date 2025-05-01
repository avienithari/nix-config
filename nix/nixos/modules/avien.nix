{ config, pkgs, ... }:

{
  users.users.avien = {
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
}
