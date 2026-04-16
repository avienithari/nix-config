{ ... }:

{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    sessionVariables = {
      EDITOR = "nvim";
    };
    shellAliases = {
      g = "git";
      vim = "nvim";
      ".." = "cd ..";
    };
    bashrcExtra = ''
      bind -x '"\C-f": "sessionizer''\n"'

      c_reset='\[\e[0m\]'
      c_love='\[\e[1;31m\]'
      c_gold='\[\e[1;33m\]'
      c_foam='\[\e[1;36m\]'
      c_iris='\[\e[1;35m\]'
      c_cyan='\[\e[1;34m\]'
      c_subtle='\[\e[1;90m\]'

      __prompt_dir() {
        if [[ "$PWD" == "$HOME" ]]; then
          printf "~"
        else
          basename "$PWD"
        fi
      }

      __set_prompt() {
        local ssh_prompt=""
        local nix_prompt=""
        local git_prompt=""

        if [[ -n "$SSH_CONNECTION" ]]; then
          ssh_prompt="''${c_love}[ssh]''${c_reset} "
        fi

        if [[ -n "$IN_NIX_SHELL" ]]; then
          nix_prompt="''${c_cyan}❄  ''${c_reset}"
        fi
        local dir_prompt="''${c_gold}$(__prompt_dir)''${c_reset}"

        if git rev-parse --is-inside-work-tree &>/dev/null; then
          local branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD)
          if [[ -n "$(git status --porcelain 2>/dev/null)" ]]; then
            git_prompt=" ''${c_subtle}git:(''${c_iris}''${branch}''${c_subtle})''${c_love} ✗''${c_reset}"
          else
            git_prompt=" ''${c_subtle}git:(''${c_iris}''${branch}''${c_subtle})''${c_reset}"
          fi
        fi

        PS1="''${ssh_prompt}''${nix_prompt}''${c_foam}\u@\h ''${dir_prompt}''${git_prompt} ''${c_reset}"
      }

      PROMPT_COMMAND=__set_prompt
    '';
  };
}
