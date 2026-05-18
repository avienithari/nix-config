{ lib, ... }:

{
  imports = [
    ./configuration.nix
    ../../users/avien
  ];

  host = {
    class = "desktop";
    session = "hyprland";
    feature = {
      steam = true;
      useHome = true;
    };
  };

  networking.hostName = lib.mkForce "barioth";

  services.openssh.settings.PasswordAuthentication = true;

  system.stateVersion = "25.05";
}
