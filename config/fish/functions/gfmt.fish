# Defined in /var/folders/71/r2v_f3cs4gnb1vbzbby1mtn80000gn/T//fish.FjZgR5/gfmt.fish @ line 2
function gfmt --description 'Format all edited Swift files in the working tree.'
    set root (git rev-parse --show-toplevel)
    git status --porcelain=v1 |
    awk '/\.swift"?$/{
        # Drop status info in front. We just want the paths.
        sub("^[ \t]*[^ \t]+[ \t]*", "")
        # Ensure the path is quoted.
        # Unknown status files, noted with ??, are not quoted.
        sub("^\"?", "\"")
        sub("\"?$", "\"")
        # Append the path to the repo root.
        x = sprintf("\"%s\"/%s", "'$root'", $0)
        print x
    }' |
    xargs swift-format format -i
end
