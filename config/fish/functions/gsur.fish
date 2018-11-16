# Defined in - @ line 0
function gsur --description 'alias gsur=git submodule update --recursive'
	git submodule update --recursive $argv;
end
