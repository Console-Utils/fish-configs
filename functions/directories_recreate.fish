function __create_directory --description 'Creates directory'
  set --local NOT_VALID_DIRECTORY_ERROR 1
  
  set --local DIRECTORY $argv[1]

  set --query PROMPT_SUCCESS_SIGN || set --local PROMPT_SUCCESS_SIGN (set_color brgreen)'✔'(set_color normal)
  set --query PROMPT_ERROR_SIGN || set --local PROMPT_ERROR_SIGN (set_color brred)'✘'(set_color normal)

  set --query PROMPT_PATH_COLOR || set --local PROMPT_PATH_COLOR (set_color brred)

  if test -d $DIRECTORY
    echo -s $PROMPT_ERROR_SIGN'Can\'t create '\
      $PROMPT_PATH_COLOR\"$DIRECTORY\"$RESET_COLOR' folder because '\
      $PROMPT_PATH_COLOR\"$DIRECTORY\"$RESET_COLOR' already exists.' >&2
    return $NOT_VALID_DIRECTORY_ERROR
  else
    mkdir $DIRECTORY
    echo $PROMPT_SUCCESS_SIGN'Folder '$PROMPT_PATH_COLOR\"$DIRECTORY\"$RESET_COLOR\
      'successfully created.'
  end
end

function directories_recreate --description 'Recreates directory structure as on my local host'
  set --local NO_REQUIRED_ENVS_ERROR 1

  set --local directories $MINE_PATH $WORK_PATH $MINE_PATH'/'{fish,bash,sed,awk}

  set --query PROMPT_VARIABLE_IDENTIFIER_COLOR || set --local PROMPT_VARIABLE_IDENTIFIER_COLOR (set_color brred)

  set --query PROMPT_ERROR_SIGN || set --local PROMPT_ERROR_SIGN (set_color brred)'✘'(set_color normal)

  if ! set --query MINE_PATH WORK_PATH
    echo -s $PROMPT_ERROR_SIGN'Can\'t proceed because any of the following variables are undefined: '\
      $PROMPT_VARIABLE_IDENTIFIER_COLOR\"MINE_PATH\"$RESET_COLOR','\
      $PROMPT_VARIABLE_IDENTIFIER_COLOR\"WORK_PATH\"$RESET_COLOR'.' >&2
    return $NO_REQUIRED_ENVS_ERROR
  end

  set --local errors 0
  set --local i 1
  for directory in $directories
    __create_directory $directory
    set errors (math $errors + $status)
  end
  
  test $errors -eq 0
  return $test
end
