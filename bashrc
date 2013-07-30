# Configure colored prompt.
export PS1="\[\e[1;34m\]\W\[\e[m\]\$ "

shopt -s autocd cdable_vars dirspell extglob globstar nocaseglob nocasematch

# source line seems to fail under cron -- brew complains that /usr/local/bin is
# not on my path when it runs
export PATH="/usr/local/bin:$PATH"
source "$HOME/.shrc"
