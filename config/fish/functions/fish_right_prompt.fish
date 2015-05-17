function fish_right_prompt
	set -l job_count (jobs | awk 'BEGIN{n=0} {n += 1} END{print n}')
    if test $job_count -gt 0
        set_color blue
        echo -n "[$job_count]"
        set_color normal
    end
end
