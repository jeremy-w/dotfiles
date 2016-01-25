function plurn --description plurn\ STROKES\[:\]\ WORD\ \[SENTENCE\]:\ Records\ word\ for\ study\ later.\n\nIf\ present,\ colon\ after\ WORD\ will\ be\ omitted,\ to\ simplify\ copy-paste\ from\ plup\ output. --argument strokes word sentence
	if not set -q JWS_PLOVER_LEARN_FILE
        set_color --bold red
        printf "$_: error: "
        set_color normal
        printf "environment variable "
        set_color --bold white
        printf "JWS_PLOVER_LEARN_FILE "
        set_color normal
        printf "must be set\n"
        return 1
    end

    # Error out if missing arguments.
    if not set -q strokes word
        set_color --bold red
        printf "$_: error: "
        set_color normal
        printf "missing arguments: expected $_ STROKES WORD [SENTENCE]\n"
        return 2
    end
    set strokes (echo $strokes | sed -e 's/:$//')

    # Default |sentence| to |word|.
    if not set -q sentence
        set sentence $word
    end

    set -l now (date +%FT%T%z)
    printf '---\n%s\n%s\n%s\n%s\n.\n' \
        $now $strokes $word $sentence \
        >> $JWS_PLOVER_LEARN_FILE
end
