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

      local ssh_indicator=""
      if [[ -n "$SSH_CONNECTION" ]]; then
        ssh_indicator="%{$fg_bold[red]%}[ssh]%{$reset_color%} "
      fi

      PROMPT="''${ssh_indicator}%(?:%{$fg_bold[green]%}%n@%m :%{$fg_bold[red]%}%n@%m )%{$fg[cyan]%}%c%{$reset_color%}"
      PROMPT+=' $(git_prompt_info)'

      ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
      ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
      ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
      ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

      PROMPT="''${ssh_indicator}%(?:%{$fg_bold[green]%}%n@%m :%{$fg_bold[red]%}%n@%m )%{$fg[cyan]%}%c%{$reset_color%} "
      PROMPT+='$(git_prompt_info)'

      ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
      ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
      ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
      ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
    '';
  };
}
