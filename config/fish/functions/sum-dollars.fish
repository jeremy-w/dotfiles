function sum-dollars --description 'Sums dollar amounts (cents optional) from stdin'
    rg -o --pcre2 '(?<=\$)\d+(.\d\d)?' | paste -sd+ - | bc
end
