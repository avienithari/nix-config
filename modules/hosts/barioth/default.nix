{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../users/avien
  ];

  host = {
    class = "server";
    feature.useHome = true;
  };

  networking.hostName = "barioth";

  system.stateVersion = "25.11";
}
