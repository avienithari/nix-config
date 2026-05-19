{ ... }:

{
  imports = [
    ./docker.nix
    ./mount-smb-share.nix
    ./private-chats.nix
    ./steam.nix
    ./torrent.nix
    ./virtualisation.nix
    ./work-packages.nix
  ];
}
