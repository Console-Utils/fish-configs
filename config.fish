#!/usr/bin/env fish

not status is-interactive && exit

fish_add_path "/home/emilyseville7cfg/.local/bin"

set -g RESET_COLOR (set_color normal)

function git_repo_recreate --description 'Recreates repo from remote'
  set -l NO_VALID_REPO_ERROR 1

  set -l PATH_COLOR (set_color brcyan)
  set -l REMOTE_COLOR (set_color brcyan)

  if test ! -d .git
    echo '❌ Can\'t recreate .git repo from remote because '$PATH_COLOR\"$PWD\"$RESET_COLOR' doesn\'t contain .git folder.' >&2
    return $NO_VALID_REPO_ERROR
  end

  set -l remote (git config --get remote.origin.url)
  if set -q $remote[1]
    echo -e '❌ Can\'t recreate .git repo from remote because '$PATH_COLOR\"$PWD\"$RESET_COLOR' repo hasn\'t '$REMOTE_COLOR\"origin\"$RESET_COLOR' remote configured.' >&2
    return $NO_VALID_REPO_ERROR
  end

  rm -rf .git
  rm -rf -- * .* &> /dev/null
  git clone $remote .
end

function create_abbrevation --description 'Creates specified abbrevation when there is no abbrevation with the same name'
  set -l ABBREVATION $argv[1]
  set -l COMMAND $argv[2]

  ! abbr -q "$ABBREVATION" && abbr -a -U $ABBREVATION $COMMAND
end

function create_abbrevations --description 'Creates missing abbrevations'
  set abbrevations cmi 'cd /home/emilyseville7cfg/Documents/mine/'
  set -a abbrevations cwo 'cd /home/emilyseville7cfg/Documents/work/'
  set -a abbrevations e echo
  set -a abbrevations f for
  set -a abbrevations gcl 'git clone'
  set -a abbrevations gfe 'git fetch'
  set -a abbrevations gin 'git init'
  set -a abbrevations gre 'e 1'
  set -a abbrevations gsy 'git pull && git push'
  set -a abbrevations gun 'rm -rf .git'
  set -a abbrevations i 'if test'
  set -a abbrevations pf printf
  set -a abbrevations r 'source /home/emilyseville7cfg/.config/fish/config.fish'
  set -a abbrevations w 'while test'

  set -l i 1
  while test $i -le (count $abbrevations)
    create_abbrevation $abbrevations[$i] $abbrevations[(math $i + 1)]
    echo $abbrevations[$i] $abbrevations[(math $i + 1)]
    set i (math $i + 2)
  end
end

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

function cwd_prompt --description 'Prints $PWD in human-readable format'
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

create_abbrevations
