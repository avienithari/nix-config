{ ... }:

{
  homebrew = {
    enable = true;
    brews = [
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
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
  };
}
