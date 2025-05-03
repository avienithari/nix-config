{ pkgs, self, username, ... }:

{
  homebrew = {
    enable = true;
    brews = [
      "lld"
      "llvm"
      "lua"
      "luarocks"
      "mas"
      "pyvim"
      "zsh-autosuggestions"
      "zsh-syntax-highlighting"
    ];
    casks = [
      "discord"
      "ghostty"
      "monitorcontrol"
      "vlc"
    ];
    masApps = {
      "Elmedia Video Player" = 1044549675;
    };
    onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
  };
}
