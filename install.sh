# Copy this up a directory, then run it.
for file in dotfiles/*; do
  name="`basename $file`"
  ln -s "$file" ".$name"
done

# Handle .ssh specially.
install -d .ssh
chmod 0700 .ssh
mv .ssh,config .ssh/config

echo "Dotfiles installed."
