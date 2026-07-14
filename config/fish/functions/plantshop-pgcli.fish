function plantshop-pgcli 
    /usr/bin/env bash -c 'set -a; source ~/git/sells-plants/0/plantshop-medusa/apps/backend/.env; set +a; pgcli $DATABASE_URL'
end
