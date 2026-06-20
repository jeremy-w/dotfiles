function jj-insert-current-file --description 'Insert a modified file from current jj change into commandline'
    set -l revset $argv[1]
    if test -z $revset
        set revset "@"
        # If none in @, then default to @-.
        set -l diff_files (jj diff --name-only -r $revset)
        if not set -q diff_files[1]
            set revset "@-"
        end
    end
    set -l file (
        jj diff --name-only -r $revset \
        | sort -u \
        | fzf \
            --prompt="file> " \
            --header="Insert file path from $revset" \
            --preview "jj diff --color=always -r $revset -- '\"{r}\"'" \
            --preview-window=right:70%
    )

    if test $status -eq 0 -a -n "$file"
        commandline --insert -- (string escape -- $file)
        commandline -f repaint
    end
end
