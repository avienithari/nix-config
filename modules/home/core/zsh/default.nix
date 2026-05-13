{ ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
    };
    sessionVariables = {
      EDITOR = "nvim";
      GPT_TTY = "$(tty)";
    };
    shellAliases = {
      ff = "fastfetch";
      vim = "nvim";
    };
    initContent = ''
      autoload -Uz edit-command-line
      zle -N edit-command-line
      bindkey '^X^E' edit-command-line
      bindkey ' ' magic-space

      bindkey -s ^f "sessionizer''\n"
      bindkey -s ^n "notes-picker''\n"

      setopt PROMPT_SUBST

      __build_prompt() {
        local ssh_prompt=""
        local nix_prompt=""
        local git_prompt=""

        local c_user="%{$fg_bold[green]%}"
        local c_user_fail="%{$fg_bold[red]%}"
        local c_dir="%{$fg[cyan]%}"
        local c_reset="%{$reset_color%}"

        local git_prefix="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
        local git_suffix="%{$reset_color%}"
        local git_dirty="%{$fg[blue]%}) %{$fg[yellow]%}✗"
        local git_clean="%{$fg[blue]%})"

        if [[ -n "$SSH_CONNECTION" ]]; then
          ssh_prompt="%{\e[1;31m%}[ssh]%{\e[0m%} "
        fi

        if [[ -n "$IN_NIX_SHELL" || -n "$DIRENV_DIR" ]]; then
          nix_prompt="%{\e[1;34m%}❄ %{\e[0m%} "

          c_user="%{\e[1;36m%}"
          c_user_fail="%{\e[1;31m%}"
          c_dir="%{\e[1;33m%}"
          c_reset="%{\e[0m%}"

          local c_subtle="%{\e[1;90m%}"
          local c_iris="%{\e[1;35m%}"
          local c_love="%{\e[1;31m%}"

          git_prefix="''${c_subtle}git:(''${c_iris}"
          git_suffix="''${c_reset}"
          git_dirty="''${c_subtle})''${c_love} ✗"
          git_clean="''${c_subtle})"
        fi

        if git rev-parse --is-inside-work-tree &>/dev/null; then
          local branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD)
          if [[ -n "$(git status --porcelain 2>/dev/null)" ]]; then
            git_prompt=" ''${git_prefix}''${branch}''${git_dirty}''${git_suffix}"
          else
            git_prompt=" ''${git_prefix}''${branch}''${git_clean}''${git_suffix}"
          fi
        fi

        echo "''${ssh_prompt}''${nix_prompt}%(?:''${c_user}%n@%m :''${c_user_fail}%n@%m )''${c_dir}%c''${c_reset}''${git_prompt} "
      }

      PROMPT='$(__build_prompt)'
    '';
  };
}
