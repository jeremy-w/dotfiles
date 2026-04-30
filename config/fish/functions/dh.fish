function dh --description 'Like dirh but with relative numbering to assist moving more than 1 directory at a time'
    set -l current (command pwd)
    set -l countdown (count $dirprev)
    for dir in $dirprev
        echo "$countdown $dir"
        set countdown (math $countdown - 1)
    end

    set_color $fish_color_history_current
    echo 0 $current
    set_color normal

    set -l countup 1
    for dir in $dirnext[-1..1]
        echo "$countup $dir"
        set countup (math $countup + 1)
    end
    echo
end
