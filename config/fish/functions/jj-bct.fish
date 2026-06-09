function jj-bct
    set bookmark $argv[-1]
    jj b c $argv
    jj b t $bookmark
end
