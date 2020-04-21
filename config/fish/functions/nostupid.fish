# Defined in /var/folders/71/r2v_f3cs4gnb1vbzbby1mtn80000gn/T//fish.uZbbNt/nostupid.fish @ line 2
function nostupid --description 'fail if any line with "nocommit" is staged for addition'
	git diff --cached | grep '^+' | not grep nocommit;
end
