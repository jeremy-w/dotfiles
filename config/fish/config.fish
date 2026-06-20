## CONFIG ##
# Tell less to always render color escapes.
# Don't use --mouse; it prevents swipe to copy-paste.
set -gx LESS --RAW-CONTROL-CHARS --ignore-case --LONG-PROMPT --incsearch
set -gx BAT_PAGER "less $LESS --quit-if-one-screen"

# Make sure we have a sane locale.
set -gx LANG "en_US.UTF-8"
set -gx LC_CTYPE "UTF-8"
set -gx LC_ALL "en_US.UTF-8"

# Neovim shall be our editor.
set -gx EDITOR "/opt/homebrew/bin/nvim"
abbr --add vi nvim

# Don't interrupt `brew install` with a `brew update`
set -gx HOMEBREW_NO_AUTO_UPDATE 1
# https://stout.neullabs.com/articles/homebrew-uses-too-much-disk-space/
set -gx HOMEBREW_CLEANUP_MAX_AGE_DAYS 14
set -gx HOMEBREW_CLEANUP_PERIODIC_FULL_DAYS 7

# Silence messages from https://npm.im/opencollective-postinstall
set -gx DISABLE_OPENCOLLECTIVE true

# Point Ripgrep at a config file.
set -gx RIPGREP_CONFIG_PATH $HOME/.config/ripgrep.rc

if status is-interactive
    source ~/.config/fish/fish_git_prompt_colors.fish

    if command -q atuin
        atuin init fish --disable-up-arrow | source
    end

    bind \cc cancel-commandline

    if command -q ngrok
        eval (ngrok completion)
    end
end

# NOTE: ~/.cabal/bin should be pretty empty. Use `cabal sandbox` instead.
# See: http://coldwa.st/e/blog/2013-08-20-Cabal-sandbox.html
#
# More recent cabal/Haskell Platform install to ~/Library/Haskell/bin.
#
# Prefix /usr/local/{,s}bin so that Homebrew's stuff takes precedence.
fish_add_path --path \
    "$HOME/usr/bin" \
    /opt/homebrew/bin \
    /opt/homebrew/sbin \
    "$HOME/Library/Haskell/bin" \
    /usr/local/bin \
    /usr/local/sbin \
    /usr/bin \
    /usr/sbin \
    /bin \
    /sbin \
    /opt/X11/bin

# Append funky paths where OS X hides things.
# LaunchServices happens to contain `lsregister`, which can be useful.
# NOTE: Used to be a /Developer/usr/sbin, but no more as of Xcode 6.3.1.
# Appending /Developer/usr/bin was messing up xcrun starting with Xcode 7.
fish_add_path --path --append \
    /usr/libexec \
    "/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support"

### RUBY ###
# rbenv sets up PATH/completions for interactive shells.
if status is-interactive; and type -q rbenv
    source (rbenv init -|psub)
end

### NODE ###
# Could use nvm if needed, but it does NOT support fish.
# There are fish wrappers/variants of it, though.

### PERL ###
# Could use in future plenv + perl-carton like rbenv + bundler.
set -gx PERL_CPANM_OPT "--local-lib=~/perl5"

### GO ###
if type -q go
    set -gx GOPATH "$HOME/usr/share/go"
    fish_add_path --path "$GOPATH/bin" /usr/local/opt/go/libexec/bin
end

### SCALA ###
if type -q scalaenv
    set -l scalaenv_shims "$HOME/.scalaenv/shims"
    fish_add_path --path $scalaenv_shims

    set -gx SCALAENV_SHELL fish
    scalaenv rehash ^/dev/null
end

### RUST ###
# rust-up actually installs cargo into the directory we're looking for.
if type -q cargo; or test -x $HOME/.cargo/bin/cargo
    set -l rust_cargo_bin "$HOME/.cargo/bin"
    fish_add_path --path $rust_cargo_bin
end

## COMPLETIONS ##
### AWS CLI: via https://stackoverflow.com/questions/26981542/aws-cli-command-completion-with-fish-shell
if type -q aws_completer
    function __fish_complete_aws
        env COMP_LINE=(commandline -pc) aws_completer | tr -d ' '
    end

    complete -c aws -f -a "(__fish_complete_aws)"
end

## COMMANDS ##
if status is-interactive
    if type -q zoxide
        zoxide init fish | source
    end
end

# pnpm
set -gx PNPM_HOME "/Users/jeremy/Library/pnpm"
fish_add_path --path "$PNPM_HOME"
# pnpm end

if [ -f ~/.config/fnox/age.txt ]
    set -gx FNOX_AGE_KEY (grep AGE-SECRET-KEY ~/.config/fnox/age.txt)
end
