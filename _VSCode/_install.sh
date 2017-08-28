set VSCODE_SETTINGS ~/Library/Application\ Support/Code/User/

# Initial import - already done
#mv $VSCODE_SETTINGS/snippets .
#mv $VSCODE_SETTINGS/keybindings.json .
#mv $VSCODE_SETTINGS/settings.json .

# Linking these into place where VSCode expects them
ln -s $PWD/snippets/ $VSCODE_SETTINGS/snippets
ln -s $PWD/keybindings.json $VSCODE_SETTINGS/keybindings.json
ln -s $PWD/settings.json $VSCODE_SETTINGS/settings.json
