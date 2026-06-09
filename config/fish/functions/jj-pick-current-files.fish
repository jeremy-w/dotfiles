function jj-pick-current-files --description 'Insert modified files from current jj change into commandline'
    set -l revset $argv[1]
    if test -z $revset
        set revset "@"
        # If none in @, then default to @-.
        if test -z (jj diff --name-only -r $revset)
            set revset "@-"
        end
    end
    set -l files (
        jj diff --name-only -r $revset \
        | sort -u \
        | fzf --multi \
            --prompt="files> " \
            --header="Insert files from $revset" \
            --preview "jj diff -r $revset -- '{}'" \
            --preview-window=right:70%
    )
    echo $files

    # if test $status -eq 0 -a (count $files) -gt 0
    #     commandline --insert -- (string join " " -- (string escape -- $files))
    #     commandline -f repaint
    # end
end
