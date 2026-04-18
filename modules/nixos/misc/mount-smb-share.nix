{ config, pkgs, username, secrets, ... }:

let
  smbCredsPath = config.age.secrets.smb.path;
in
{
  environment.systemPackages = with pkgs; [ cifs-utils ];

  age.secrets."smb".file = "${secrets}/smb.age";

  fileSystems."/home/${username}/testies" = {
    device = "//192.168.0.253/avien-smb";
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
