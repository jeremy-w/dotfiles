## CONFIG ##
# Tell less to always render color escapes.
setenv LESS -R

# Make sure we have a sane locale.
setenv LANG "en_US.UTF-8"
setenv LC_CTYPE "UTF-8"
setenv LC_ALL "en_US.UTF-8"

# Vim shall be our editor.
setenv EDITOR "/usr/bin/vim"

source ~/.config/fish/fish_git_prompt_colors.fish


# Don't interrupt `brew install` with a `brew update`
setenv HOMEBREW_NO_AUTO_UPDATE 1

# Silence messages from https://npm.im/opencollective-postinstall
setenv DISABLE_OPENCOLLECTIVE true


## PATH MANAGEMENT ##
# fish_user_paths is automatically prepended to PATH and can be universal.
# See: https://github.com/fish-shell/fish-shell/issues/527#issuecomment-13315434
# But `set --append fish_user_paths some/path/here` is your friend.
#
# We won't manage it here, since the idea is the user edits it themselves
# as desired for that specific machine.
function wants_path -a path
    set wants_path_verbose 0
    if test ! -d $path -a $wants_path_verbose -eq 1
        echo "wants_path: skipped absent directory: $path" >&2
    end
    begin
        not contains "$path" $PATH
        and test -d "$path"
    end
end

# We will, however, feel free to tack stuff we think they missed onto PATH. :)
#
# NOTE: ~/.cabal/bin should be pretty empty. Use `cabal sandbox` instead.
# See: http://coldwa.st/e/blog/2013-08-20-Cabal-sandbox.html
#
# More recent cabal/Haskell Platform install to ~/Library/Haskell/bin.
#
# Prefix /usr/local/{,s}bin so that Homebrew's stuff takes precedence.
set -l paths_to_prepend "$HOME/usr/bin" \
    /opt/homebrew/bin /opt/homebrew/sbin \
    "$HOME/Library/Haskell/bin" \
    /usr/local/bin /usr/local/sbin
# For sanity, ensure we include standard paths.
set -l paths_to_prepend $paths_to_prepend {/usr,}/bin {/usr,}/sbin /opt/X11/bin
for path in $paths_to_prepend[-1..1]
    if wants_path "$path"
        set -gx PATH "$path" $PATH
    end
end

# Append funky paths where OS X hides things.
# LaunchServices happens to contain `lsregister`, which can be useful.
# NOTE: Used to be a /Developer/usr/sbin, but no more as of Xcode 6.3.1.
# Appending /Developer/usr/bin was messing up xcrun starting with Xcode 7.
set -l paths_to_append /usr/libexec \
    "/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support"
for path in $paths_to_append
    if wants_path "$path"
        set -gx PATH $PATH "$path"
    end
end

### RUBY ###
# Let rbenv work its PATH magic.
if type -q rbenv
    # rbenv since version 1.0 of 2015-12-24 supports fish.
    status --is-interactive; and source (rbenv init -|psub)
end

### PYTHON ###
function jws_pyenv_init
    # Let pyenv work its PATH magic.
    # py3.3+ has pyvenv baked in to replace virtualenv.
    # py3.4+ has pip baked in.
    if type -q pyenv
        # `pyenv init` prefixes with `status --is-interactive; and`, but I think
        # you'd want the correct environment even in non-interactive shells, no?
        # fishism: psub: does process substitution by using a named pipe.
        source (pyenv init -|psub)
    end

    # Use pyenv-virtualenv to allow pyenv to treat a venv as a python version.
    # This allows sharing configuration across projects.
    #
    # Invoke as: pyenv virtualenv $PYTHON_VERSION $NEW_VENV_DIRECTORY_NAME
    # The venvs live in ~/.pyenv/versions/$NEW_VENV_DIRECTORY_NAME.
    #
    # See: http://www.chriskrycho.com/2015/a-modern-python-development-toolchain.html
    #
    # Sourcing it lets it automatically de/activate the appropriate virtualenv
    # when you enter a directory hierarchy.
    if type -q pyenv-virtualenv-init
        source (pyenv virtualenv-init -|psub)
    end
end

### NODE ###
# Could use nvm if needed, but it does NOT support fish.
# There are fish wrappers/variants of it, though.

### PERL ###
# Could use in future plenv + perl-carton like rbenv + bundler.
setenv PERL_CPANM_OPT "--local-lib=~/perl5"

### GO ###
if type -q go
    setenv GOPATH "$HOME/usr/share/go"
    for godir in "$GOPATH/bin" /usr/local/opt/go/libexec/bin
        if wants_path "$godir"
            set PATH $PATH "$godir"
        end
    end
end

### SCALA ###
if type -q scalaenv
    set -l scalaenv_shims "$HOME/.scalaenv/shims"
    if wants_path $scalaenv_shims
        set PATH $scalaenv_shims $PATH
    end

    set -x SCALAENV_SHELL fish
    scalaenv rehash ^/dev/null
end

### RUST ###
# rust-up actually installs cargo into the directory we're looking for.
if type -q cargo; or test -x $HOME/.cargo/bin/cargo
    set -l rust_cargo_bin "$HOME/.cargo/bin"
    if wants_path $rust_cargo_bin
        set PATH $rust_cargo_bin $PATH
    end
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
# autojump adds a `j` command for jumping to a directory.
# It hooks into directory changes to create a weighted list of directories
# for use in selecting which directory to jump to.
[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish

# OPAM configuration
# OPAM's variables stuff breaks PATH, which is fun:
#     PATH=/Users/jeremy/.opam/system/bin:/Users/jeremy/.pyenv/shims /Users/jeremy/.rbenv/shims
# Note the : alongside the other array bits.
# It makes this mistake several times over.
#. /Users/jeremy/.opam/opam-init/init.fish > /dev/null 2> /dev/null or true


## SYSTEM PREFERENCES ##
# Prevent `--` from turning into an en-dash, while still leaving smart quotes
# enabled. <URL:http://mjtsai.com/blog/2016/04/25/outsmarting-the-smart-dash/>
[ -x (which defaults) ]; and defaults write -g NSAutomaticDashSubstitutionEnabled 0

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /Users/jeremy/dotfiles/config/yarn/global/node_modules/tabtab/.completions/serverless.fish ]; and . /Users/jeremy/dotfiles/config/yarn/global/node_modules/tabtab/.completions/serverless.fish
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /Users/jeremy/dotfiles/config/yarn/global/node_modules/tabtab/.completions/sls.fish ]; and . /Users/jeremy/dotfiles/config/yarn/global/node_modules/tabtab/.completions/sls.fish

# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[ -f /Users/jeremy/dotfiles/config/yarn/global/node_modules/tabtab/.completions/slss.fish ]; and . /Users/jeremy/dotfiles/config/yarn/global/node_modules/tabtab/.completions/slss.fish
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH
