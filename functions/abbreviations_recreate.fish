function __create_abbreviation --description 'Creates specified abbreviation'
  set --local NOT_VALID_ABBREVIATION_ERROR 1
  
  set --local ABBREVIATION $argv[1]
  set --local COMMAND $argv[2]

  set --query PROMPT_SUCCESS_SIGN || set --local PROMPT_SUCCESS_SIGN (set_color brgreen)'✔'(set_color normal)
  set --query PROMPT_ERROR_SIGN || set --local PROMPT_ERROR_SIGN (set_color brred)'✘'(set_color normal)

  set --query PROMPT_ABBR_IDENTIFIER || set --local PROMPT_ABBR_IDENTIFIER (set_color brcyan)

  if abbr --query $ABBREVIATION
    echo -s $PROMPT_ERROR_SIGN'Can\'t create '\
      $PROMPT_ABBR_IDENTIFIER\"$COMMAND\"$RESET_COLOR' abbreviation because '\
      $PROMPT_ABBR_IDENTIFIER\"$ABBREVIATION\"$RESET_COLOR' already exists.' >&2
    return $NOT_VALID_ABBREVIATION_ERROR
  end
  
  abbr --add --universal $abbreviation $COMMAND
  echo $PROMPT_SUCCESS_SIGN'Abbreviation '$PROMPT_ABBR_IDENTIFIER\"$ABBREVIATION\"$RESET_COLOR\
    'successfully recreated from remote.'
end

function abbreviations_recreate --description 'Creates missing abbreviations'
  set abbreviations cmi 'cd /home/emilyseville7cfg/Documents/mine/'
  set --append abbreviations cwo 'cd /home/emilyseville7cfg/Documents/work/'
  set --append abbreviations e echo
  set --append abbreviations f for
  set --append abbreviations gcl 'git clone'
  set --append abbreviations gfe 'git fetch'
  set --append abbreviations gin 'git init'
  set --append abbreviations gre 'git_repo_recreate'
  set --append abbreviations gsy 'git pull && git push'
  set --append abbreviations gun 'rm -rf .git'
  set --append abbreviations i 'if test'
  set --append abbreviations pf printf
  set --append abbreviations r 'source /home/emilyseville7cfg/.config/fish/config.fish'
  set --append abbreviations w 'while test'

  set --local errors 0
  set --local i 1
  while test $i -le (count $abbreviations)
    __create_abbreviation $abbreviations[$i] $abbreviations[(math $i + 1)]
    set errors (math $errors + $status)
    set i (math $i + 2)
  end

  test $errors -eq 0
  return $test
end
