# Defined in /var/folders/71/r2v_f3cs4gnb1vbzbby1mtn80000gn/T//fish.MKYCVq/git-apple-browse.fish @ line 1
function git-apple-browse --description Open\ origin\'s\ GitHub\ Enterprise\ page\ in\ Safari
	set -l origin (git remote get-url origin | sed -e 's/^git@//' -e 's,:,/,')
open -a Safari.app "https://$origin"
end
