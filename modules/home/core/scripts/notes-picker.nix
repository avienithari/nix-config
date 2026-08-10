{ pkgs, ... }:

let
  find = "${pkgs.findutils}/bin/find";
  fzf = "${pkgs.fzf}/bin/fzf";
  nvim = "${pkgs.neovim}/bin/nvim";
in
pkgs.writeShellScriptBin "notes-picker" ''
  if [[ $# -eq 1 ]]; then
    selected=$1
  else
    selected=$(${find} "$HOME/notes" -type f -name "*.md" 2>/dev/null \
      | ${fzf} --prompt="Note> ")
  fi

  if [[ -z "$selected" ]]; then
    exit 0
  fi

  ${nvim} "$selected"
''
