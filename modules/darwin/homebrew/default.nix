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
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
  };
}
