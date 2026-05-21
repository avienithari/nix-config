{ config, lib, modulesPath, username, ... }:

let
  mediaPath = "/home/${username}/media";
in
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd = {
      availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
      kernelModules = [ ];
    };

    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [ ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/b09a415d-1c86-434a-af1f-d7a421eb096b";
      fsType = "ext4";
    };

    "${mediaPath}/scale" = {
      device = "/dev/disk/by-uuid/791f1e91-2a7a-4b2c-97ae-127c7d164958";
      fsType = "ext4";
      options = [ "defaults" "noatime" "nofail" ];
    };

    "${mediaPath}/data" = {
      device = "/dev/disk/by-uuid/5d2bdf16-d8b2-4a4c-9123-0c85a440d346";
      fsType = "ext4";
      options = [ "defaults" "noatime" "nofail" ];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/9AEF-2F98";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };
  };

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
