{ config, pkgs, username, secrets, ... }:

let
  smbCredsPath = config.age.secrets.smb.path;
  private = import "${secrets}/private.nix";
  nasAddress = private.services.nas.ip;
  sambaShareName = private.services.nas."${username}Share";
  device = "//${nasAddress}/${sambaShareName}";
  mountPoint = "/home/${username}/media/samba";
in
{
  environment.systemPackages = with pkgs; [ cifs-utils ];

  age.secrets."smb".file = "${secrets}/smb.age";

  fileSystems."${mountPoint}" = {
    inherit device;
    fsType = "cifs";
    options = [
      "x-systemd.automount"
      "noauto"
      "x-systemd.idle-timeout=60"
      "credentials=${smbCredsPath}"
      "uid=1000"
      "gid=100"
      "_netdev"
    ];
  };
}
