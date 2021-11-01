function __create_abbrevation --description 'Creates specified abbrevation when there is no abbrevation with the same name'
  set --local ABBREVATION $argv[1]
  set --local COMMAND $argv[2]

  ! abbr -q "$ABBREVATION" && abbr -a -U $ABBREVATION $COMMAND
end

function abbrevations_recreate --description 'Creates missing abbrevations'
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
