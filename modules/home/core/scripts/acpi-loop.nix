{ pkgs, ... }:

pkgs.writeShellScriptBin "acpi-loop" ''
  #! /usr/bin/env bash

  while true; do
      acpi
      sleep 60
  done
''
