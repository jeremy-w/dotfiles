function casa-pgcli
    /usr/bin/env bash -c 'set -a; source ~/git/wintriad/casa/core-api/.env; set +a; pgcli --init-command "set search_path to propco_portal, public;"'
end
