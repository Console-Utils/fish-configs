#!/usr/bin/env fish

not status is-interactive && exit

fish_add_path "/home/emilyseville7cfg/.local/bin"

set -g MINE_PATH "~/Documents/mine"
set -g WORK_PATH "~/Documents/work"

function transform_path --description 'Replaces $HOME with tilde and mine/work dirs with special keywords'
  set -l directory $argv[1]

  set -l directory (string replace --regex '^'"$HOME" '~' $directory)

  set -l directory (string replace --regex '^'"$MINE_PATH" '\$MINE_PATH' $directory)
  set -l directory (string replace --regex '^'"$WORK_PATH" '\$WORK_PATH' $directory)

  echo $directory
end

function colorize_path --description 'Colorizes path'
  set -l directory $argv[1]

  set -l RESET_COLOR (set_color normal)

  set -l SLASH_COLOR (set_color brblue)
  set -l PATH_COLOR (set_color brcyan)

  set -l MINE_COLOR (set_color --bold)
  set -l WORK_COLOR (set_color --bold)

  set -l directory (string replace --regex '^(\$MINE_PATH)' "$MINE_COLOR"'🏠$1'"$RESET_COLOR" $directory)
  set -l directory (string replace --regex '^(\$WORK_PATH)' "$WORK_COLOR"'🏢$1'"$RESET_COLOR" $directory)

  set -l directory $PATH_COLOR$directory
  set -l directory (string replace --regex --all '/' "$SLASH_COLOR"'/'"$PATH_COLOR" $directory)
  set -l directory $directory$RESET_COLOR

  echo $directory
end

function cwd_prompt
  set -l directory $PWD

  set -l directory (transform_path $directory)
  set -l directory (colorize_path $directory)

  echo $directory
end

function fish_prompt
  set -l user_char '💲'
  fish_is_root_user && set user_char '⭐💲'

  echo -s (set_color yellow) (cwd_prompt) $user_char
end
