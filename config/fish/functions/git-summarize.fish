# Defined in /var/folders/71/r2v_f3cs4gnb1vbzbby1mtn80000gn/T//fish.VOFam8/git-summarize.fish @ line 2
function git-summarize --description 'Summarize changes between current branch and master'
	git diff --name-only master... | sed -e 's/^/- /' $argv;
end
