{ ... }:

{
  programs.ghostty = {
    enable = true;
    settings = {
      font-size = 14;
      font-family = "JetBrains Mono Nerd Font";
      theme = "Rose Pine";
      cursor-style = "block";
      cursor-style-blink = false;
      shell-integration-features = "no-cursor";
      mouse-hide-while-typing = true;
      mouse-scroll-multiplier = 2;
      confirm-close-surface = false;
      quit-after-last-window-closed = true;
    };
  };
}
