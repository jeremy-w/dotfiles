function jj-insert-change-id --description 'Insert a changeset ID into commandline'
    set -l revset $argv[1]
    if test -z $revset
        set revset (jj config get revsets.log)
    end
    set fish_trace 1
    set -l fmt (jj config get 'template-aliases."builtin_log_oneline(commit)"' | sd -F '++ "\n"' '' | string collect)
    set -l fmt $fmt' ++ "\t" ++ format_short_change_id_with_change_offset(self) ++ "\n"'
    set -l change_id (
        jj log --color=always -T (printf $fmt | sd -F 'commit.' 'self.' | sd -F '(commit)' '(self)' | string collect) -r $revset \
        | fzf \
            --ansi \
            --delimiter=\t \
            --with-nth=1 \
#            --preview='jj show --color=always {2}' \
        | cut -f2
    )

    if test $status -eq 0 -a -n "$change_id"
        commandline --insert -- (string escape -- $change_id)
        commandline -f repaint
    end
end
