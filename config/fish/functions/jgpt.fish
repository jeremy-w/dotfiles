function jgpt --wraps='jj git push --tracked' --description 'alias jgpt jj git push --tracked'
    jj git push --tracked $argv
end
