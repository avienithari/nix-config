{ username, ... }:

{
  imports = [
    ../../home/core/zsh
  ];

  home = {
    inherit username;
    stateVersion = "26.05";
  };
}
