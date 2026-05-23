{ config, lib, secrets, username, ... }:

let
  cfg = config.host.feature.syncthingWebUi;
  private = import "${secrets}/private.nix";
  syncthingPasswordPath = config.age.secrets.syncthing-password.path;
in
{
  age.secrets."syncthing-password" = {
    file = "${secrets}/syncthing-password.age";
    owner = username;
    group = "users";
  };

  systemd.services.syncthing.serviceConfig.WorkingDirectory =
    "/home/${username}";

  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    dataDir = "/home/${username}";
    configDir = "/home/${username}/.config/syncthing";
    group = "users";
    user = "${username}";

    guiAddress = lib.mkIf cfg "0.0.0.0:8384";
    guiPasswordFile = lib.mkIf cfg syncthingPasswordPath;

    overrideDevices = false;
    overrideFolders = false;

    relay.enable = false;

    settings = {
      inherit (private.services.syncthing) devices folders;

      gui = lib.mkIf cfg {
        user = "${username}";
      };

      options = {
        urAccepted = -1;
        relaysEnabled = false;
        localAnnounceEnabled = true;
        globalAnnounceEnabled = false;
      };
    };
  };

  networking.firewall.allowedTCPPorts = lib.mkIf cfg [ 8384 ];
}
