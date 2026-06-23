{ pkgs ? import <nixpkgs> { } }:

let
  qtcolorwidgets = pkgs.fetchFromGitLab {
    owner = "mattbas";
    repo = "Qt-Color-Widgets";
    rev = "3.0.0";
    hash = "sha256-rglt89Gw6OHXXVOEwf0TxezDzyHEvWepeGeup7fBlLs=";
  };

  kdsingleapplication = pkgs.fetchFromGitHub {
    owner = "KDAB";
    repo = "KDSingleApplication";
    rev = "v1.2.0";
    hash = "sha256-rglt89Gw6OHXXVOEwf0TxezDzyHEvWepeGeup7fBlLs=";
  };
in
pkgs.flameshot.overrideAttrs (oldAttrs: rec {
  pname = "flameshot";
  version = "v14.0.0";

  src = pkgs.fetchFromGitHub {
    owner = "${pname}-org";
    repo = "${pname}";
    rev = "${version}";
    hash = "sha256-GnJ3nOJyyqQbCTMrTYhnQfEOXqCy0x3IapX/PsaZ3VI=";
  };

  patches = [ ];

  cmakeFlags = (oldAttrs.cmakeFlags or [ ]) ++ [
    "-DFETCHCONTENT_SOURCE_DIR_QTCOLORWIDGETS=${qtcolorwidgets}"
    "-DFETCHCONTENT_SOURCE_DIR_KDSINGLEAPPLICATION=${kdsingleapplication}"
  ];
})
