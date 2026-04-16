{ ... }:

{
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    historyWidgetOptions = [
      "--layout=reverse"
      "--height=11"
      "--info=inline"
    ];
    colors = {
      "fg" = "#e0def4";
      "bg" = "#191724";
      "hl" = "#ebbcba";
      "fg+" = "#e0def4";
      "bg+" = "#26233a";
      "hl+" = "#ebbcba";
      "info" = "#f6c177";
      "prompt" = "#31748f";
      "pointer" = "#c4a7e7";
      "marker" = "#eb6f92";
      "spinner" = "#9ccfd8";
      "header" = "#908caa";
    };
  };
}
