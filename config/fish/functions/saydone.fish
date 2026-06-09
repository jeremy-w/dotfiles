function saydone
    set -l exit_status $status
    if test $exit_status -eq 0
        say '[[slnc 300]] done [[slnc 300]]'
        afplay /System/Library/Sounds/Blow.aiff
     else
        say "[[slnc 300]] failed $exit_status [[slnc 300]]"
        afplay /System/Library/Sounds/Sosumi.aiff
     end
end
