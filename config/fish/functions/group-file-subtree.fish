function group-file-subtree --description 'Regroups files under folders with the provided prefix into a folder with the name of that prefix. Effectively flattens the tree.'
    argparse --min-args=1 -- $argv || return
    set prefix $argv[1]
    mkdir -p $prefix
    for file in (fd -p $prefix -t f)
        mv $file $prefix/
        set dir (dirname $file)
        if not contains $dir $dirs
            set dirs $dirs $dir
        end
    end
    for dir in (path sort -r $dirs)
        rmdir -p $dir
    end
end
