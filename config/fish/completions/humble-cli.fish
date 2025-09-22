complete -c humble-cli -n "__fish_use_subcommand" -s h -l help -d 'Print help information'
complete -c humble-cli -n "__fish_use_subcommand" -s V -l version -d 'Print version information'
complete -c humble-cli -n "__fish_use_subcommand" -f -a "auth" -d 'Set the authentication session key'
complete -c humble-cli -n "__fish_use_subcommand" -f -a "list" -d 'List all your purchased bundles'
complete -c humble-cli -n "__fish_use_subcommand" -f -a "list-choices" -d 'List your current Humble Choices'
complete -c humble-cli -n "__fish_use_subcommand" -f -a "details" -d 'Print details of a certain bundle'
complete -c humble-cli -n "__fish_use_subcommand" -f -a "download" -d 'Selectively download items from a bundle'
complete -c humble-cli -n "__fish_use_subcommand" -f -a "search" -d 'Search through all bundle products for keywords'
complete -c humble-cli -n "__fish_use_subcommand" -f -a "completion" -d 'Generate shell completions'
complete -c humble-cli -n "__fish_use_subcommand" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c humble-cli -n "__fish_seen_subcommand_from auth" -s h -l help -d 'Print help information'
complete -c humble-cli -n "__fish_seen_subcommand_from list" -l claimed -d 'Show claimed or unclaimed bundles only' -r -f -a "{all	,yes	,no	}"
complete -c humble-cli -n "__fish_seen_subcommand_from list" -l id-only -d 'Print bundle IDs only'
complete -c humble-cli -n "__fish_seen_subcommand_from list" -s h -l help -d 'Print help information'
complete -c humble-cli -n "__fish_seen_subcommand_from list-choices" -s h -l help -d 'Print help information'
complete -c humble-cli -n "__fish_seen_subcommand_from details" -s h -l help -d 'Print help information'
complete -c humble-cli -n "__fish_seen_subcommand_from download" -s i -l item-numbers -d 'Download only specified items' -r
complete -c humble-cli -n "__fish_seen_subcommand_from download" -s f -l format -d 'Filter downloaded items by their format' -r
complete -c humble-cli -n "__fish_seen_subcommand_from download" -s s -l max-size -d 'Filter downloaded items by their maximum size' -r
complete -c humble-cli -n "__fish_seen_subcommand_from download" -s t -l torrents -d 'Download only .torrent files for items'
complete -c humble-cli -n "__fish_seen_subcommand_from download" -s h -l help -d 'Print help information'
complete -c humble-cli -n "__fish_seen_subcommand_from search" -l mode -d 'Whether all or any of the keywords should match the name' -r -f -a "{all	,any	}"
complete -c humble-cli -n "__fish_seen_subcommand_from search" -s h -l help -d 'Print help information'
complete -c humble-cli -n "__fish_seen_subcommand_from completion" -s h -l help -d 'Print help information'
