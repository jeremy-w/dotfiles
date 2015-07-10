# Copy this up a directory, then run it.
warn_count=0
error_count=0
for file in dotfiles/*; do
  name="`basename $file`"
  target=".$name"
  # Avoid putting a directory link inside an extant directory.
  if test -L "$target"; then
    echo "$0: warning: $target: already a symlink - skipping" 1>&2
    warn_count=`expr $warn_count + 1`
  elif test -d "$target"; then
    echo "$0: error: $target: directory exists - skipping" 1>&2
    error_count=`expr $error_count + 1`
  else
    if ln -s "$file" "$target"; then
    else
        error_count=`expr $error_count + 1`
    fi
  fi
done

# Handle .ssh specially.
install -d .ssh
chmod 0700 .ssh
mv .ssh,config .ssh/config

rm .install-dotfiles.sh
echo "$0: dotfiles installed: $warn_count warnings, $error_count errors"
