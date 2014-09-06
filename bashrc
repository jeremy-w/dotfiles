# Configure colored prompt.
PS1="\[\e[1;34m\]\W\[\e[m\]\$ "

# Don't export PS1; most shells don't share config styles.
declare +x PS1

shopt -s cdable_vars extglob nocaseglob nocasematch

# OS X bash doesn't support autocd, dirspell, globstar.
can_shopt=$(shopt)
maybe_shopt() {
    if [[ shopt =~ "$1" ]]; then
        shopt -s autocd
    fi
}
maybe_shopt autocd
maybe_shopt dirspell
maybe_shopt globstar

# source line seems to fail under cron -- brew complains that /usr/local/bin is
# not on my path when it runs
export PATH="/usr/local/bin:$PATH"
. "$HOME/.shrc"
