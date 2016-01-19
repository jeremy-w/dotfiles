function rbenv
	set -l command $argv[1]
        if test (count $argv) -gt 1
            set argv $argv[2..-1]
        else
            set argv
        end

        switch "$command"
            case rehash shell
                eval (rbenv "sh-$command" $argv)
            case '*'
                command rbenv "$command" $argv
        end
end
