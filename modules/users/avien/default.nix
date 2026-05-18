{ pkgs, ... }:

{
  users.users.avien = {
    isNormalUser = true;
    description = "avien";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  programs.zsh.enable = true;
}
