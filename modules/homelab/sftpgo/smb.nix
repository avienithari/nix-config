{ config, pkgs, secrets, ... }:

let
  private = import "${secrets}/private.nix";
  nasAddress = private.services.nas.ip;
  share = private.services.nas.shares.sftp;
  credsPath = config.age.secrets.rathian-sftp-smb.path;
in
{
  age.secrets."rathian-sftp-smb".file =
    "${secrets}/${share.secretsFile}";

  environment.systemPackages = with pkgs; [ cifs-utils ];

  fileSystems."/mnt/sftp" = {
    device = "//${nasAddress}/${share.shareName}";
    fsType = "cifs";
    options = [
      "x-systemd.automount"
      "noauto"
      "x-systemd.idle-timeout=60"
      "credentials=${credsPath}"
      "uid=sftpgo"
      "gid=users"
      "dir_mode=0770"
      "file_mode=0660"
      "_netdev"
    ];
  };
}
