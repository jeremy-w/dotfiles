# Execute this from the directory above this.
find dotfiles -maxdepth 1 -exec ln -s "{}" ".{}" \;
install -d .ssh
chmod 0700 .ssh
mv .ssh_config .ssh/config
echo "Dotfiles installed. You probably should nuke the .git that just got linked in, though."
