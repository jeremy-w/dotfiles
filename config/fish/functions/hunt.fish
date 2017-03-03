function hunt
	find . -type d -name tmp -prune -o $argv -print
end
