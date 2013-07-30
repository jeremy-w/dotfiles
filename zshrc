# Runtime profiling
# PS4="+ $(~/bin/now) %N:%i"$'\011 '
# setopt promptsubst xtrace
# The following lines were added by compinstall {{{

zstyle ':completion:*' completer _expand _complete _ignored _correct
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]} r:|[._-+]=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle :compinstall filename '/Users/jeremy/.zshrc'

# From "Writing Zsh Completion Functions" by John Beppu, 2002-07-15,
# Linux Magazine. http://www.linux-mag.com/id/1106/
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''

autoload -Uz compinit
compinit
# End of lines added by compinstall }}}
# Lines configured by zsh-newuser-install {{{
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob
bindkey -e
# End of lines configured by zsh-newuser-install }}}
setopt histnostore histignoredups histverify
setopt pushdignoredups autopushd

# Configure colored prompt
export PS1="%B%F{blue}%1~%f%b%% "

source "$HOME/.shrc"

# Add user functions to fpath.
if [[ -d ~/.zsh/functions/ ]]; then
  fpath=('~/.zsh/functions' $fpath);
fi

# Automatically remove duplicates from these arrays
typeset -U path cdpath fpath manpath

# Treat / as a word separator.
# This simplifies rewriting paths via backward-kill-word.
export WORDCHARS="${WORDCHARS:s|/|}"

# Enable resume directory in Terminal.app
if [[ $TERM_PROGRAM == "Apple_Terminal" ]] && [[ -z "$INSIDE_EMACS" ]]; then
  function chpwd {
    local SEARCH=' '
    local REPLACE='%20'
    local PWD_URL="file://$HOSTNAME${PWD//$SEARCH/$REPLACE}"
    printf '\e]7;%s\a' "$PWD_URL"
  }
  chpwd
fi

function j {
    DIR=$(autojump "$*")
    cd "$DIR"
}

# End runtime profiling.
# setopt nopromptsubst noxtrace
