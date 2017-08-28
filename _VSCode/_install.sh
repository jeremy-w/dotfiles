# NOTE: This expects to be run in this directory!
# Install and launch VSCode once before running this.
set VSCODE_SETTINGS ~/Library/Application\ Support/Code/User/

# Initial import - already done
#mv $VSCODE_SETTINGS/snippets .
#mv $VSCODE_SETTINGS/keybindings.json .
#mv $VSCODE_SETTINGS/settings.json .

# Linking these into place where VSCode expects them
set base (dirname $0)

# New VSCode creates an empty snippets folder.
rmdir $VSCODE_SETTINGS/snippets
ln -s $PWD/snippets/ $VSCODE_SETTINGS/snippets

# It doesn't create keybindings or settings, though.
ln -s $PWD/keybindings.json $VSCODE_SETTINGS/keybindings.json
ln -s $PWD/settings.json $VSCODE_SETTINGS/settings.json
