function plup --description 'Searches for words in all configured Plover dictionaries.'
	set -l config "$HOME/Library/Application Support/plover/plover.cfg"
    set -l dict_files (awk 'BEGIN{FS=" = "} /^dictionary_file/{print($2)}' $config)
    for word in $argv
        egrep -i $word -- $dict_files
    end
end
