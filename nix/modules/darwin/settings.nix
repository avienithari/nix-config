{ pkgs, self, username, ... }:

{
  system.defaults = {
    NSGlobalDomain.KeyRepeat = 2;
  };

  nix.settings.experimental-features = "nix-command flakes";

  programs.zsh.enable = true;

  system.configurationRevision = self.rev or self.dirtyRev or null;

  system.stateVersion = 6;
}
