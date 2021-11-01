#!/usr/bin/env fish

not status is-interactive && exit

fish_add_path "/home/emilyseville7cfg/.local/bin"

set -g RESET_COLOR (set_color normal)

function git_repo_recreate --description 'Recreates repo from remote'
  set --local NO_VALID_REPO_ERROR 1

  set --local PATH_COLOR (set_color brcyan)
  set --local REMOTE_COLOR (set_color brcyan)

  if test ! -d .git
    echo '❌ Can\'t recreate .git repo from remote because '$PATH_COLOR\"$PWD\"$RESET_COLOR' doesn\'t contain .git folder.' >&2
    return $NO_VALID_REPO_ERROR
  end

  set --local remote (git config --get remote.origin.url)
  if set -q $remote[1]
    echo -e '❌ Can\'t recreate .git repo from remote because '$PATH_COLOR\"$PWD\"$RESET_COLOR' repo hasn\'t '$REMOTE_COLOR\"origin\"$RESET_COLOR' remote configured.' >&2
    return $NO_VALID_REPO_ERROR
  end

  rm -rf .git
  rm -rf -- * .* &> /dev/null
  git clone $remote .
end

function create_abbrevation --description 'Creates specified abbrevation when there is no abbrevation with the same name'
  set --local ABBREVATION $argv[1]
  set --local COMMAND $argv[2]

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
  set -a abbrevations gre 'git_repo_recreate'
  set -a abbrevations gsy 'git pull && git push'
  set -a abbrevations gun 'rm -rf .git'
  set -a abbrevations i 'if test'
  set -a abbrevations pf printf
  set -a abbrevations r 'source /home/emilyseville7cfg/.config/fish/config.fish'
  set -a abbrevations w 'while test'

  set --local i 1
  while test $i -le (count $abbrevations)
    create_abbrevation $abbrevations[$i] $abbrevations[(math $i + 1)]
    set i (math $i + 2)
  end
end

set -g MINE_PATH "~/Documents/mine"
set -g WORK_PATH "~/Documents/work"

function transform_path --description 'Replaces $HOME with tilde and mine/work dirs with special keywords'
  set --local directory $argv[1]

  set --local directory (string replace --regex '^'"$HOME" '~' $directory)

  set --local directory (string replace --regex '^'"$MINE_PATH" '\$MINE_PATH' $directory)
  set --local directory (string replace --regex '^'"$WORK_PATH" '\$WORK_PATH' $directory)

  echo $directory
end

function colorize_path --description 'Colorizes path'
  set --local directory $argv[1]

  set --local SLASH_COLOR (set_color brblue)
  set --local PATH_COLOR (set_color brcyan)

  set --local MINE_COLOR (set_color --bold)
  set --local WORK_COLOR (set_color --bold)

  set --local directory (string replace --regex '^(\$MINE_PATH)' "$MINE_COLOR"'🏠$1'"$RESET_COLOR" $directory)
  set --local directory (string replace --regex '^(\$WORK_PATH)' "$WORK_COLOR"'🏢$1'"$RESET_COLOR" $directory)

  set --local directory $PATH_COLOR$directory
  set --local directory (string replace --regex --all '/' "$SLASH_COLOR"'/'"$PATH_COLOR" $directory)
  set --local directory $directory$RESET_COLOR

  echo $directory
end

function cwd_prompt --description 'Prints $PWD in human-readable format'
  set --local directory $PWD

  set --local directory (transform_path $directory)
  set --local directory (colorize_path $directory)

  echo $directory
end

function pipestatus_prompt --description 'Prints $pipestatus in human-readable format'
  set --local statuses $argv

  set --local BRACKETS_COLOR (set_color red)
  set --local DELIMITER_COLOR (set_color purple)
  set --local STATUS_COLOR (set_color brred)

  echo -n $BRACKETS_COLOR'['

  for i in (seq 1 (count $statuses))
    echo -n $STATUS_COLOR$statuses[$i]
    test $i -lt (count $statuses) && echo -n $DELIMITER_COLOR'|'
  end

  echo -n $BRACKETS_COLOR']'
end

function fish_prompt
  set --local statuses $pipestatus

  set --local user_char '💲'
  fish_is_root_user && set user_char '⭐💲'

  echo -s (set_color yellow) (cwd_prompt) (pipestatus_prompt $statuses) $user_char
end

create_abbrevations
