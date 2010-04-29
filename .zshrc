# History stuff
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# Variables
export EDITOR="vim"
export PAGER="less"
export PATH="${PATH}:${HOME}/docs/scripts"

# Keybindings {{{
bindkey -v
typeset -g -A key
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line
bindkey '^?' backward-delete-char
bindkey '^[[1~' beginning-of-line
bindkey '^[[5~' up-line-or-history
bindkey '^[[3~' delete-char
bindkey '^[[4~' end-of-line
bindkey '^[[6~' down-line-or-history
bindkey '^[[A' up-line-or-search
bindkey '^[[D' backward-char
bindkey '^[[B' down-line-or-search
bindkey '^[[C' forward-char 
# for rxvt
bindkey "\e[8~" end-of-line
bindkey "\e[7~" beginning-of-line
# }}}

# Alias stuff
alias mkdir='mkdir -p'
alias rm='rm -R'
alias cp='cp -R'
alias urxvt='urxvtc'
alias ls='ls --group-directories --color -F'
alias ll='ls --group-directories --color -lh'
alias lf='ls *(.)'
alias lrf='ls **/*(.)'
alias .='cd ..'
alias ..='cd ../..'
alias ...='cd ../../..'
alias ....='cd ../../../..'

alias rw-='chmod 600'
alias rwx='chmod 700'
alias r--='chmod 644'
alias r-x='chmod 755'

alias dj='python manage.py'
alias djr='python manage.py runserver'

export GREP_COLOR=31
alias grep='grep --color=auto'

# Man en couleur
export LESS_TERMCAP_mb=$'\E[01;31m'    # début de blink
export LESS_TERMCAP_md=$'\E[01;31m'    # début de gras
export LESS_TERMCAP_me=$'\E[0m'        # fin
export LESS_TERMCAP_so=$'\E[01;44;33m' # début de la ligne d`état
export LESS_TERMCAP_se=$'\E[0m'        # fin
export LESS_TERMCAP_us=$'\E[01;32m'    # début de souligné
export LESS_TERMCAP_ue=$'\E[0m'        # fin]

# Comp stuff
unsetopt list_ambiguous

zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}'
zstyle ':completion:*' max-errors 3 numeric
zstyle ':completion:*' use-compctl false

autoload -Uz compinit
compinit

zstyle :compinstall filename '${HOME}/.zshrc'

setopt correct
setopt autocd

# Historique {{{
# Tout enregistrer
setopt inc_append_history
# Pas de doublons
setopt hist_ignore_dups
setopt hist_expire_dups_first
setopt hist_find_no_dups
# }}}

# Demande confirmation pour 'rm *'
unsetopt rm_star_silent
setopt nullglob

setopt AUTO_CONTINUE
# Completition milieu du mot
setopt COMPLETE_IN_WORD

extract() {
    if [ -f "$1" ] ; then
        case "$1" in
            *.tar.bz2) tar xvjf "$1"   ;;
            *.tar.gz)  tar xvzf "$1"   ;;
            *.bz2)     bunzip2 "$1"    ;;
            *.rar)     unrar x "$1"    ;;
            *.gz)      gunzip "$1"     ;;
            *.tar)     tar xvf "$1"    ;;
            *.tbz2)    tar xvjf "$1"   ;;
            *.tgz)     tar xvzf "$1"   ;;
            *.zip)     unzip "$1"      ;;
            *.Z)       uncompress "$1" ;;
            *.7z)      7z x "$1"       ;;
            *)
            echo "'$1' cannot be extracted"
            return 1
            ;;
        esac
    else
        echo "'$1' is not a valid file"
        return 1
    fi
    return 0
}

# {{{ Prompt settings
setopt extended_glob
setopt prompt_subst
autoload colors zsh/terminfo
if [[ "$terminfo[colors]" -ge 8 ]]; then
    colors
fi

for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
(( count = $count + 1 ))
done

PR_NO_COLOUR="%{$terminfo[sgr0]%}"
PR_TITLEBAR=$'%{\e]0;%(!.*ROOT* | .)%n@%m:%~\a%}'
PROMPT='$PR_BLUE%n$PR_WHITE@$PR_GREEN%m$PR_WHITE:$PR_RED%/$PR_NO_COLOUR '
# }}}
