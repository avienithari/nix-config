{ ... }:

{
  programs.zathura = {
    enable = true;

    options = {
      statusbar-basename = true;
      statusbar-page-percent = true;
      selection-clipboard = "clipboard";
      selection-notification = false;
    };

    mappings = {
      "D" = "feedkeys <C-f><S-p>";
      "U" = "feedkeys <C-b><S-p>";
    };
  };
}
