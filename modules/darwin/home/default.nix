{ username, ... }:

{
  imports = [
    ../../home/core/zsh
    ./ghostty
  ];

  home = {
    inherit username;
    stateVersion = "26.05";
  };
}
