{ config, pkgs, secrets, ... }:

let
  private = import "${secrets}/private.nix";
  nasAddress = private.services.nas.ip;
  share = private.services.nas.shares.download;
  credsPath = config.age.secrets.rathian-download-smb.path;
in
{
  age.secrets."rathian-download-smb".file =
    "${secrets}/${share.secretsFile}";

  environment.systemPackages = with pkgs; [ cifs-utils ];

  fileSystems."/mnt/downloads" = {
    device = "//${nasAddress}/${share.shareName}";
    fsType = "cifs";
    options = [
      "x-systemd.automount"
      "noauto"
      "x-systemd.idle-timeout=60"
      "credentials=${credsPath}"
      "uid=deluge"
      "gid=users"
      "dir_mode=0770"
      "file_mode=0660"
      "_netdev"
    ];
  };
}
