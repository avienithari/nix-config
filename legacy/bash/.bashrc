#!/bin/bash
alias vim="nvim"

config() {
    declare -ag segments=(identity timestamp path git prompt)
    declare -ag dynamics=(identity git)

    declare -g use_colors=true
    declare -g use_glyphs=true
    declare -g use_badges=true

    declare -g color_primary="#f6c177"
    declare -g color_secondary="#908caa"
    declare -g color_neutral="#6e6a86"
    declare -g color_global

    declare -g glyph_badge_left=""
    declare -g glyph_badge_right=""

    if is_root; then
        color_global=$color_secondary
    else
        color_global=$color_primary
    fi

    if is_console; then use_glyphs=false; fi

    PS1=""
    PS2="→ "
    PROMPT_DIRTRIM=2
    export GIT_PS1_SHOWUNTRACKEDFILES=1
    export GIT_PS1_SHOWDIRTYSTATE=1

    if [[ $PROMPT_COMMAND != *__print_blank* ]]; then
        PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND; }__print_blank"
    fi
}

init() {
    for segment in "${segments[@]}"; do
        renderer="render_$segment"

        if ! declare -F "$renderer" > /dev/null; then continue; fi

        if [[ "${dynamics[*]}" =~ $segment ]]; then
            PS1+="\$($renderer) "
        else
            PS1+="$($renderer) "
        fi
    done
}

render_identity() {
    local status=$?
    local glyph
    local label

    if is_error "$status"; then
        if $use_glyphs; then glyph=""; else glyph="!"; fi
        glyph="\001\033[5m\002$glyph\001\033[25m\002"
    elif is_ssh; then
        if $use_glyphs; then glyph="󰌘"; else glyph="*"; fi
    elif is_root; then
        if $use_glyphs; then glyph=""; else glyph="#"; fi
    else
        if $use_glyphs; then glyph=""; else glyph="$"; fi
    fi

    if is_ssh || is_su; then
        label="$USER@$HOSTNAME"
    elif is_git; then
        label=$(get_git_project)
    else
        label="$HOSTNAME"
    fi

    if $use_badges; then
        make_badge "$glyph $label"
    else
        make_label "$glyph $label"
    fi
}

render_timestamp() {
    local label="\T"

    if $use_badges; then
        make_label "$label"
    else
        make_label "[$label]" "$color_neutral"
    fi
}

render_path() {
    local glyph=" "
    local label="\w"

    if $use_glyphs; then
        printf "%s %s" "$(make_label "$glyph")" "$label"
    else
        printf "%s" "$label"
    fi
}

render_git() {
    local glyph=""
    local label="%s"

    if ! is_git; then return 1; fi

    if ! $use_badges; then
        label="($label)"
    fi

    if $use_glyphs; then
        label="$glyph $label"
    fi

    if $use_badges; then
        format="$(make_badge "$label" "$color_neutral")"
    elif $use_colors; then
        format="$(make_label "$label" "$color_secondary")"
    else
        format="$label"
    fi

    if command -v __git_ps1 >/dev/null 2>&1; then
        __git_ps1 "$format"
    fi
}

render_prompt() {
    local glyph

    if $use_glyphs && $use_badges; then glyph="󱞩"; else glyph="→"; fi

    if $use_badges; then glyph=" $glyph"; fi

    if $use_glyphs && $use_badges; then
        glyph="\001\033[1m\002$glyph\001\033[0m\002"
    fi

    printf "\n%s" "$(make_label "$glyph")"
}

hex_to_ansi() {
    local hex=${1#\#}
    local include_bg=${2:-false}

    local r=$((16#${hex:0:2}))
    local g=$((16#${hex:2:2}))
    local b=$((16#${hex:4:2}))

    if $include_bg; then printf "30;48;"; fi

    printf "2;%s;%s;%s" "$r" "$g" "$b"
}

make_label() {
    local content=$1
    local color=${2:-$color_global}

    if [[ -z $content ]]; then return 1; fi

    if $use_colors; then
        printf "\001\033[38;%sm\002" "$(hex_to_ansi "$color")"
    fi

    printf "%b" "$content"

    if $use_colors; then
        printf "\001\033[0m\002"
    fi
}

make_badge() {
    local content=$1
    local color=${2:-$color_global}
    local glyph_left
    local glyph_right
    local ansi_sequence

    if [[ -z $content ]]; then return 1; fi

    if $use_glyphs; then
        glyph_left=$glyph_badge_left
        glyph_right=$glyph_badge_right
    else
        content=" $content "
    fi

    if $use_colors; then
        ansi_sequence=$(hex_to_ansi "$color" true)
    else
        ansi_sequence=7
    fi

    printf "%s" "$(make_label "$glyph_left" "$color")"
    printf "\001\033[%sm\002" "$ansi_sequence"
    printf "%b" "$content"
    printf "\001\033[0m\002"
    printf "%s" "$(make_label "$glyph_right" "$color")"
}

is_root() { [[ $EUID -eq 0 ]]; }

is_su() { [[ -n $LOGNAME && $USER != "$LOGNAME" ]]; }

is_ssh() { [[ -n "$SSH_CLIENT" ]]; }

is_console() { [[ -t 1 && $TERM == linux ]]; }

is_error() { [[ $1 -ne 0 && $1 -ne 130 ]]; }

is_git() { [[ -n $(get_git_project) ]]; }

get_git_project() {
    if ! command -v git > /dev/null 2>&1; then return 1; fi

    if git_root=$(git rev-parse --show-toplevel 2>/dev/null); then
        printf "%s" "${git_root##*/}"
    fi
}

__print_blank() { [[ -n $__was_printed ]] && echo; __was_printed=1; }

alias clear="command clear; unset __was_printed"

config && init
