{ ... }:

{
  imports = [
    ./docker.nix
    # ./mount-smb-share.nix
    ./private-chats.nix
    ./steam.nix
    ./torrent.nix
    ./work-packages.nix
  ];
}
