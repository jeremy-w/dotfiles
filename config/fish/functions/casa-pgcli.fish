function casa-pgcli
    cd ~/git/wintriad/casa/core-api/ && uvx --from python-dotenv[cli] dotenv run pgcli --init-command 'set search_path to propco_portal, public;'
end
