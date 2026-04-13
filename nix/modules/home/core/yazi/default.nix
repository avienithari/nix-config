{ pkgs, ... }:

let
  rosePineYazi = fetchGit {
    url = "https://github.com/rose-pine/yazi.git";
    ref = "main";
    rev = "c89d745573d4fcfe0550fe6646f9f9ab1c0e51db";
  };
in
{
  programs.yazi = {
    enable = true;
    package = pkgs.yazi;
    flavors = {
      rose-pine = "${rosePineYazi}/flavors/rose-pine.yazi";
    };
    theme = {
      flavor = {
        dark = "rose-pine";
      };
    } // (fromTOML (builtins.readFile "${rosePineYazi}/themes/rose-pine.toml"));
    settings = {
      mgr = {
        sort_by = "natural";
      };
    };
  };
}
