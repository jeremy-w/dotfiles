function plup --description 'Searches for words in all configured Plover dictionaries.'
	set -l base "$HOME/Library/Application Support/plover"
	set -l config "$base/plover.cfg"
    set -l dict_files (awk 'BEGIN{FS=" = "} /^dictionary_file/{ path = $2; sub(/^~/, "'$HOME'", path); print(path);}' $config)

    # Recent Plover builds use a path relative to $config, at least for
    # sibling files.
    for i in (seq (count $dict_files))
        set -l fnam $dict_files[$i]
        if test (dirname $fnam) = .
            set dict_files[$i] "$base/$fnam"
        end
    end

    for word in $argv
        egrep -i $word -- $dict_files
    end
end
