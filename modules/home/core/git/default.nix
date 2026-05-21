{ secrets, username, ... }:

let
  private = import "${secrets}/private.nix";
  userKeys = private.users.${username};
in
{
  programs.git = {
    enable = true;
    settings = [
      {
        user = {
          name = "avienithari";
          email = "125766902+avienithari@users.noreply.github.com";
        };
      }
      {
        init = {
          defaultBranch = "master";
        };
      }
      {
        pull = {
          rebase = true;
        };
      }
    ];

    signing = {
      signByDefault = true;
      format = "ssh";
      key = userKeys.signingKeyPath;
    };

    ignores = [
      "*.db"
      "*.swn"
      "*.swo"
      "*.swp"
      "*sync-conflict*"
      "*testies*"
      "*~"
      ".byebug_history"
      ".cache/"
      ".DS_Store"
      ".env"
      ".gradle"
      ".idea"
      ".notes*"
      ".ruby-lsp"
      ".rvmrc"
      ".sass-cache"
      ".stfolder"
      ".stversions"
      ".syncthing*"
      "_pycache_"
      "build"
      "compile_commands.json"
      "npm-debug.log"
      "portkey.json"
      "secrets"
      ".direnv"
    ];
  };
}
