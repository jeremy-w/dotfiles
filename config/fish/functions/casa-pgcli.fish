function casa-pgcli
    cd ~/git/wintriad/casa/core-api/ && /usr/bin/env bash -c 'set -a; source .env; set +a; pgcli --init-command "set search_path to propco_portal, public;"'
end
