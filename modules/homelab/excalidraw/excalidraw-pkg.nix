{ pkgs ? import <nixpkgs> { } }:

let
  version = "0.18.1";

  src = pkgs.fetchFromGitHub {
    owner = "excalidraw";
    repo = "excalidraw";
    rev = "v${version}";
    hash = "sha256-XhxNXi6JwBq5vw+/6HQTp6NPX3etmCkdBdNboeBru/k=";
  };
in
pkgs.stdenv.mkDerivation {
  pname = "excalidraw";
  inherit version src;

  nativeBuildInputs = with pkgs; [
    nodejs_22
    (yarn.override { nodejs = nodejs_22; })
    fixup-yarn-lock
    sass
  ];

  offlineCache = pkgs.fetchYarnDeps {
    yarnLock = "${src}/yarn.lock";
    hash = "sha256-otUEr4bGhOGYQmfELShqc8lXbRs0gA0ycbGHzyCW8tc=";
  };

  postPatch = ''
    find . -name "package.json" -exec sed -i 's/cross-env //g' {} +
  '';

  configurePhase = ''
    export HOME=$(mktemp -d)

    yarn config --offline set yarn-offline-mirror $offlineCache
    fixup-yarn-lock yarn.lock

    yarn install --offline --frozen-lockfile --ignore-scripts --no-progress

    patchShebangs node_modules
    export PATH=$PWD/node_modules/.bin:$PATH
  '';

  buildPhase = ''
    export VITE_APP_GIT_SHA="v${version}"
    export VERCEL_GIT_COMMIT_SHA="v${version}"

    yarn --offline build
  '';

  installPhase = ''
    mkdir -p $out/share/excalidraw
    cp -r excalidraw-app/build/* $out/share/excalidraw/
  '';
}
