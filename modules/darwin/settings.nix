{ self, ... }:

{
  system = {
    stateVersion = 6;
    configurationRevision = self.rev or self.dirtyRev or null;

    defaults = {
      NSGlobalDomain.KeyRepeat = 2;
    };
  };

  nix.settings.experimental-features = "nix-command flakes";

  programs.zsh.enable = true;
}
