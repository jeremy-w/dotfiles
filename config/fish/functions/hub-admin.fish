function hub-admin
    set repo $argv[1]
    hub api /repos/$repo/collaborators |
        jq -r '.[] | select(.permissions.admin == true) | .login'
end
