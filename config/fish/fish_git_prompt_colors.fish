# Custom colors
set -l branch_color a9f5a9
set -l dirtystate_color facc2e
set -l stagedstate_color f7fe2e
set -l invalidstate_color red
set -l untracked_color bdbdbd
set -l cleanstate_color 2efe2e

# Git prompt settings
set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_hide_untrackedfiles 0
set -g __fish_git_prompt_showdirtystate 'yes'
set -g __fish_git_prompt_showstashstate 'yes'
set -g __fish_git_prompt_color_branch $branch_color
set -g __fish_git_prompt_showupstream "informative"

set -g __fish_git_prompt_char_upstream_ahead "⤒"
set -g __fish_git_prompt_char_upstream_behind "⤓"
# set -g __fish_git_prompt_char_upstream_prefix ""
set -g __fish_git_prompt_char_stagedstate "±"
set -g __fish_git_prompt_char_dirtystate "!"
set -g __fish_git_prompt_char_stashstate "^"
set -g __fish_git_prompt_char_untrackedfiles "?"
set -g __fish_git_prompt_char_conflictedstate "*"
set -g __fish_git_prompt_char_cleanstate "√"
set -g __fish_git_prompt_color_dirtystate $dirtystate_color
set -g __fish_git_prompt_color_stagedstate $stagedstate_color
set -g __fish_git_prompt_color_invalidstate $invalidstate_color
set -g __fish_git_prompt_color_untrackedfiles $untracked_color
set -g __fish_git_prompt_color_cleanstate $cleanstate_color
