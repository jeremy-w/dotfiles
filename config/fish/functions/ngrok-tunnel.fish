function ngrok-tunnel
    set -l domain (ngrok api reserved-domains list 2>/dev/null | jq -r '.reserved_domains[0].domain')
    ngrok http 4000 --domain $domain
end
