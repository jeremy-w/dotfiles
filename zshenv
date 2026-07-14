# .zshenv: always loaded; env vars that need to be everywhere, eg PATH, EDITOR,
#          LANG, LC_*
# .zprofile: login shells only; login-time setup
# .zshrc: interactive shells only; aliases, prompt, completion, keybinds, etc
# .zlogin: login shells, after .zshrc; used for final login actions, if at all
# .zlogout: login shell exit; used for cleanup
PG_PATH="$HOME/Applications/Postgres.app/Contents/Versions/latest/bin/"
if [ -d "$PG_PATH" ]; then
  PATH="$PG_PATH:$PATH"
fi
