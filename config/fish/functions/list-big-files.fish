function list-big-files --description 'list-big-files 250 swift dir/: list .swift files under dir having >250 lines'
	set -l big_linecount 250
    set -l extension swift
    set -l root .
    switch (count $argv)
    case 0:
        ;
    case 1:
        set -l root $argv[0]
    case 2:
        set -l extension $argv[0]
        set -l root $argv[1]
    case 3:
        set -l big_linecount $argv[0]
        set -l extension $argv[1]
        set -l root $argv[2]
    default:
        echo 'error: list-big-files: too many arguments: expected 0-3 args' >/dev/stderr
        exit 1
    end
    echo "$extension files under $root with >= $big_linecount lines:"
    find $root -name '*.'$extension -print0 | xargs -0 wc -l | sort -rn \
    | awk '/^ *total/{/*d*/} // { if ($1 > '$big_linecount') { print($0); } }'
end
