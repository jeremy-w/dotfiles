function utcnow
	date -u +'%FT%TZ' $argv;
end
