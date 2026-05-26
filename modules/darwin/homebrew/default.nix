{ ... }:

{
  homebrew = {
    enable = true;
    brews = [
      "lld"
      "llvm"
      "lua"
      "luarocks"
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
