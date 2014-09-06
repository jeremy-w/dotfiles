# Runtime profiling
# PS4="+ $(~/bin/now) %N:%i"$'\011 '
# setopt promptsubst xtrace

# The following lines were added by compinstall {{{
zstyle ':completion:*' completer _expand _complete _ignored _correct
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]} r:|[._-+]=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle :compinstall filename '/Users/jeremy/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall }}}
# Automatically cd to directories issued as commands.
setopt autocd

# Automatically push new directories we change to onto the dirstack.
# Don't add any duplicates though.
setopt autopushd pushdignoredups 

# Treat pushd with no args as pushd ~. This mirrors cd with no args.
# This turns out to be a bad idea, as I expect pushd with no args to
# be pushd +1, and use it all the time.
#setopt pushd_to_home

# Configure colored prompt
# %!: current history event number
# %1~: 1 trailing path component; use ~ abbreviation when shorter
# %?: last job exit code; could use printexitvalue instead
# %j: number of jobs; using transient RPS1 when non-zero instead
PS1='%F{blue}%!:%B%1~%b%f%% '

# Print job exit code when non-zero.
# Generally, they complain well enough on their own, so no need for this.
#setopt printexitvalue

# Include execution context %_ in xtrace prompt.
PS4='+%N:%i:%_>'

# Disappear the RPROMPT after moving to the next command line.
setopt transient_rprompt

# Show job count when non-zero on RHS.
RPS1='%1(j.%j.)'

# Don't export prompts; shells don't share magic symbols.
declare +x PS1
declare +x RPS1
declare +x PS4

# Load configuration shared between bash and zsh.
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

### EDITING ###
# Use Emacs keybindings.
bindkey -e

# Enable extended globbing, which makes ~#^ special.
setopt extendedglob

# Enable composing a commandline in $EDITOR via Meta-e.
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\M-e' edit-command-line

# Sort globs with number-awareness, so foo10 comes after foo2, not before.
setopt numeric_glob_sort

# Only error out if none of the globs match.
setopt csh_null_glob

# Don't allow clobbering files on first shot with redirection, but make
# it easy to clobber on second though via history.
setopt noclobber
setopt hist_allow_clobber

# Don't let me accidentally ^D out of my shell. Ignore till 10th press.
setopt ignore_eof

### COMPLETION ###
# Use internal pager when too many matches. See listscroll keymap.
zmodload zsh/complist
zstyle ':completion:*:default' list-prompt '%S%M matches %s'

# Use menu selection when we hit pager.
zstyle ':completion:*:default' menu 'yes=0' 'select=long-list'

# Allow to stay in menu and pick another option with ^o.
bindkey -M menuselect '^o' accept-and-menu-complete

# Split manpage listings out by section.
zstyle ':completion:*:manuals' separate-sections true

# Substitute in the sole argument's docs when option itself isn't doc'd.
zstyle ':completion:*:default' auto-description 'specify: %d'

# List options after partial completion immediately
setopt nolist_ambiguous

# Don't beep at me when you need to complete.
setopt nolist_beep

# From "Writing Zsh Completion Functions" by John Beppu, 2002-07-15,
# Linux Magazine. http://www.linux-mag.com/id/1106/
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''

### HISTORY ###
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=5000

# Don't save fc -l invocations in history.
setopt histnostore

# Don't directly execute the result of history expansion.
# Add to editing buffer instead.
setopt histverify

# Share history, but allow me to decide when to read it in using fc -R.
setopt inc_append_history
setopt append_history

# Prevent a history search from returning a duplicate.
setopt hist_find_no_dups

# Prune history in a clever way.
setopt hist_expire_dups_first
setopt hist_save_no_dups

# Clean up history entries a bit
setopt hist_reduce_blanks

# Make space perform history expansion.
bindkey ' ' magic-space

# End runtime profiling.
# setopt nopromptsubst noxtrace
