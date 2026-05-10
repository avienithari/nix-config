{ pkgs ? import <nixpkgs> { } }:

pkgs.buildGoModule {
  pname = "strings";
  version = "1.0.0";

  src = fetchGit {
    url = "git@github.com:avienithari/strings.git";
    ref = "main";
    rev = "11d8f76b1f535b3b44bba304299246c2dfd253d2";
  };

  vendorHash = null;
}
