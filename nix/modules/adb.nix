{ config, pkgs, username, ... }:

{
  environment.systemPackages = with pkgs; [
    android-tools
    bc
  ];

  users.users.${username} = {
    extraGroups = [ "adbusers" ];
  };
}
