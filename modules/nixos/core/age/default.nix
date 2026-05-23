{ username, secrets, ... }:

let
  private = import "${secrets}/private.nix";
  userKeys = private.users.${username};
in
{
  age.identityPaths = [
    "/etc/ssh/ssh_host_ed25519_key"
    "/etc/ssh/ssh_host_rsa_key"
    "${userKeys.agenixKeyPath}"
  ];
}
