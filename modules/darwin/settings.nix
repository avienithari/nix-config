{ self, ... }:

{
  system.defaults = {
    NSGlobalDomain.KeyRepeat = 2;
    configurationRevision = self.rev or self.dirtyRev or null;
    stateVersion = 6;
  };

  nix.settings.experimental-features = "nix-command flakes";

  programs.zsh.enable = true;
}
