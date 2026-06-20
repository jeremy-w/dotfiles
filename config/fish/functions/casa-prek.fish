function casa-prek
    if set -q argv[1]
      set base $argv[1]
    else
      set base 'fork_point(@ | bookmarks())'
    end
    set revset "$base::@"
    set commit (
        jj show --color=always -T builtin_log_oneline -r $base |
        head -1
        )
    set files (jj diff --name-only -r $revset)
    if test (count $files) -eq 0
        echo "No changed files since:"
        echo $commit
        return 0
    end
    echo "Scanning files changed since:"
    echo $commit
    echo -e (string join "\n- " '' $files)
    echo
    SKIP=alembic-check .venv/bin/pre-commit run --file $files
end
