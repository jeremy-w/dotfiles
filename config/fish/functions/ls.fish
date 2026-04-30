# Defined in /var/folders/cd/hfx1wsqd23j4ht0g532jdt4w0000gp/T//fish.RLH3fC/ls.fish @ line 2
function ls --description 'alias ls ls -FG@eh,'
 if command -q eza
   # eza -F can take a "when" argument, so needs to be separate.
   # -@ is too verbose to use always, showing the bytes for the keys.
   eza --header --classify=auto $argv
 else
    # Not in the eza list:
    # -, to include thousands separators - unneeded with -h.
    # -e to include ACLs with -l output (does nothing unless -l passed)
    # eza lacks ACL support as of 2026-04-11.
    command ls -FG@eh, $argv;
 end
end
