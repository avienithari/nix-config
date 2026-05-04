{ config, lib, pkgs, username, ... }:

{
  config = lib.mkIf config.host.feature.virtualisation {
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;

    virtualisation.libvirtd.qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
    };

    users.users.${username} = {
      extraGroups = [ "libvirtd" ];
    };
  };
}
