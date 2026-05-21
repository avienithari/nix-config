{ secrets, username, ... }:

let
  private = import "${secrets}/private.nix";
  userKeys = private.users.${username};
in
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings = {
      "github.com" = {
        IdentitiesOnly = true;
        IdentityFile = userKeys.githubKeyPath;
        AddKeysToAgent = true;
      };

      "*" = {
        IdentitiesOnly = true;
        IdentityFile = userKeys.privateKeyPath;
        HashKnownHosts = true;
      };
    };
  };
}
