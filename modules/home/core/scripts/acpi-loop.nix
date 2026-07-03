{ pkgs, ... }:

pkgs.writeShellScriptBin "acpi-loop" ''
  while true; do
    ${pkgs.acpi}/bin/acpi
    ${pkgs.coreutils}/bin/sleep 60
  done
''
