{ pkgs ? import <nixpkgs> { } }:

pkgs.buildNpmPackage {
  pname = "dsite";
  version = "1.0.0";

  src = fetchGit {
    url = "git@github.com:avienithari/dsite.git";
    ref = "main";
    rev = "22c3017c20a397416ab461c4627049fdf1a93eaa";
  };

  npmDepsHash = "sha256-k3XH1YichNevIv2pqgqww6CtPK4Mo8ABvkF8EswdZpY=";
  installPhase = ''
    runHook preInstall
    mkdir -p $out
    cp -r dist/* $out/
    runHook postInstall
  '';
}
