function casa-toolong
    tokei --streaming json | jq -r 'select(.language == "Python") | .stats | {name, code: .stats.code} | select(.code > 300) | "\(.code) \(.name)"' | sort -n
end
