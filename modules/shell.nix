{ inputs, system }:

let
  pkgs = inputs.nixpkgs.legacyPackages.${system};
in
pkgs.mkShell {
  packages = with pkgs; [
    deadnix
    statix
  ];
}
