# Defined in /var/folders/71/r2v_f3cs4gnb1vbzbby1mtn80000gn/T//fish.trbmoF/git-delta.fish @ line 1
function git-delta --description 'Reports lines changed against origin/main. Clobbers pasteboard.'
    git diff --shortstat origin/main | pbcopy && pbpaste
end
