#!/usr/bin/env fish

not status is-interactive && exit

fish_add_path "/home/emilyseville7cfg/.local/bin"

function print_pwd
  set -l directory $PWD
  set -l directory (string replace --regex '^'"$HOME" '~' $directory)

  set -l MINE_PATH "~/Documents/mine"
  set -l WORK_PATH "~/Documents/work"

  set -l directory (string replace --regex '^'"$MINE_PATH" '\$MINE_PATH' $directory)
  set -l directory (string replace --regex '^'"$WORK_PATH" '\$WORK_PATH' $directory)

  set -l RESET_COLOR (set_color normal)

  set -l SLASH_COLOR (set_color brblue)
  set -l PATH_COLOR (set_color brcyan)

  set -l directory $PATH_COLOR$directory
  set -l directory (string replace --regex --all '/' "$SLASH_COLOR"'/'"$PATH_COLOR" $directory)
  set -l directory $directory$RESET_COLOR

  set -l MINE_COLOR (set_color --bold)
  set -l WORK_COLOR (set_color --bold)

  set -l directory (string replace --regex '(\$MINE_PATH)' "$MINE_COLOR"'$1'"$RESET_COLOR" $directory)
  set -l directory (string replace --regex '(\$WORK_PATH)' "$WORK_COLOR"'$1'"$RESET_COLOR" $directory)

  echo $directory
end

function fish_prompt
  set -l user_char '💲'
  fish_is_root_user && set user_char '⭐💲'

  echo -s (set_color yellow) (print_pwd) $user_char
end
