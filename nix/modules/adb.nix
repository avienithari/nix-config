{ config, pkgs, username, ... }:

{
  environment.systemPackages = with pkgs; [
    android-tools
    bc
  ];

  programs.adb.enable = true;

  users.users.${username} = {
    extraGroups = [ "adbusers" ];
  };
}
