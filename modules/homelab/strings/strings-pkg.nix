{ pkgs ? import <nixpkgs> { } }:

pkgs.buildGoModule {
  pname = "strings";
  version = "1.0.0";

  src = fetchGit {
    url = "git@github.com:avienithari/strings.git";
    ref = "main";
    rev = "3b9c03c92b0f017c7b28535504d5d958f94ab491";
  };

  vendorHash = null;
}
