#!/bin/bash
# Links VS Code config files from the folder containing this script into the folder where it expects to find them.
thisDotfilesFolder=$(dirname "$0")

# Install and launch VSCode once before running this.
# Settings locations are doc'd at: https://code.visualstudio.com/docs/getstarted/settings#_settings-file-locations
unameOut="$(uname -s)"
case $(uname -s) in
    Linux*) platformSettingsFolder="$HOME/.config/Code/User/"
        ;;
    Darwin*) platformSettingsFolder="$HOME/Library/Application\ Support/Code/User/"
        ;;
    CYGWIN* | MINGW*) platformSettingsFolder="$APPDATA/Code/User"
        ;;
    *)
        echo "$0: No clue where VS Code settings are hiding under $unameOut. Bailing." 1>&2
        exit 1
        ;;
esac

# For reference, the files to be installed were originally imported using commands like:
#       for file in snippets keybindings.json settings.json; do
#           mv "$platformSettingsFolder/$file" .
#       done

# New VSCode creates an empty snippets folder.
rmdir "$platformSettingsFolder/snippets"
ln -s "$thisDotfilesFolder/snippets/" "$platformSettingsFolder/snippets"

# It doesn't create keybindings or settings, though.
ln -s "$thisDotfilesFolder/keybindings.json" "$platformSettingsFolder/keybindings.json"
ln -s "$thisDotfilesFolder/settings.json" "$platformSettingsFolder/settings.json"
