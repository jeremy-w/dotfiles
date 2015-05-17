## CONFIG ##
setenv LESS -R
setenv LANG "en_US.UTF-8"
setenv LC_CTYPE "UTF-8"
setenv EDITOR "/usr/bin/vim"

## PATH MANAGEMENT ##
# fish_user_paths is automatically prepended to PATH and can be universal.
# We won't manage it here, since the idea is the user edits it themselves
# as desired for that specific machine.

function wants_path -a path
    if not test -d "$path"
        echo "$_: refusing to add non-existent directory to PATH: $path" >&2
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
# Prefix /usr/local/{,s}bin so that Homebrew's stuff takes precedence.
set -l paths_to_prepend "$HOME/usr/bin" "$HOME/.cabal/bin" /usr/local/{,s}bin
# For sanity, ensure we include standard paths.
set -l paths_to_prepend $paths_to_prepend {/usr,}/bin {/usr,}/sbin /opt/X11/bin
for path in $paths_to_prepend[-1..1]
    if wants_path "$path"
        setenv PATH "$path" $PATH
    end
end

# Append funky paths where OS X hides things.
# LaunchServices happens to contain `lsregister`, which can be useful.
# NOTE: Used to be a /Developer/usr/sbin, but no more as of Xcode 6.3.1.
set -l paths_to_append /usr/libexec /Developer/usr/bin \
    "/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support"
for path in $paths_to_append
    if wants_path "$path"
        setenv PATH $PATH "$path"
    end
end

### RUBY ###
# Let rbenv work its PATH magic.
if type rbenv >/dev/null ^/dev/null
    # Actually, rbenv init doesn't handle fish.
    # Let's do it manually.
    set PATH "$HOME/.rbenv/shims" $PATH
    rbenv rehash ^/dev/null
    function rbenv
        set -l command $argv[1]
        if test (count $argv) -gt 1
            set argv $argv[2..-1]
        end

        switch "$command"
            case rehash shell
                eval (rbenv "sh-$command" $argv)
            case '*'
                command rbenv "$command" $argv
        end
    end
end

### PYTHON ###
# Let pyenv work its PATH magic.
# py3.3+ has pyvenv baked in to replace virtualenv.
# py3.4+ has pip baked in.
if type pyenv >/dev/null ^/dev/null
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
# Sourcing it lets it automatically de/active the appropriate virtualenv
# when you enter a directory hierarchy.
if type pyenv-virtualenv-init >/dev/null ^/dev/null
    source (pyenv virtualenv-init -|psub)
end

### NODE ###
# Could use nvm if needed, but it does NOT support fish.
# There are fish wrappers/variants of it, though.

### PERL ###
# Could use in future plenv + perl-carton like rbenv + bundler.
setenv PERL_CPANM_OPT "--local-lib=~/perl5"

### GO ###
setenv GOPATH "$HOME/usr/share/go"
for godir in "$GOPATH/bin" /usr/local/opt/go/libexec/bin
    if wants_path "$godir"
        set PATH $PATH "$godir"
    end
end

## COMMANDS ##
# autojump adds a `j` command for jumping to a directory.
# It hooks into directory changes to create a weighted list of directories
# for use in selecting which directory to jump to.
[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish
