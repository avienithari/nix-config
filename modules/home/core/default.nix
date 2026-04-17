{ ... }:

{
  home.username = "avien";
  home.homeDirectory = "/home/avien";
  home.stateVersion = "26.05";

  imports = [
    ./bash
    ./fastfetch
    ./fzf
    ./scripts
    ./tmux
    ./user-services
    ./yazi
    ./zsh
  ];
}
