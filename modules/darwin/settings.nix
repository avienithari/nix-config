{ self, ... }:

{
  system = {
    stateVersion = 6;
    configurationRevision = self.rev or self.dirtyRev or null;

    defaults = {
      NSGlobalDomain.KeyRepeat = 2;
    };
  };

  programs.zsh.enable = true;
}
