{ pkgs, ... }:

pkgs.writeShellScriptBin "notes-picker" ''
  #!/usr/bin/env bash

  if [[ $# -eq 1 ]]; then
    selected=$1
  else
    selected=$(find "$HOME/notes" -type f -name "*.md" 2>/dev/null \
      | fzf --prompt="Note> ")
  fi

  if [[ -z "$selected" ]]; then
    exit 0
  fi

  nvim "$selected"
''
