function directories_recreate --description 'Recreates directory structure as on my local host'
  set --query PROMPT_SUCCESS_SIGN || set --local PROMPT_SUCCESS_SIGN (set_color brgreen)'✔'(set_color normal)
  set --query PROMPT_ERROR_SIGN || set --local PROMPT_ERROR_SIGN (set_color brred)'✘'(set_color normal)

  set --query PROMPT_PATH_COLOR || set --local PROMPT_PATH_COLOR (set_color brred)

  if test -d $MINE_PATH
    echo -s $PROMPT_ERROR_SIGN'Can\'t create '\
      $PROMPT_PATH_COLOR\"$MINE_PATH\"$RESET_COLOR' folder because '\
      $PROMPT_PATH_COLOR\"$MINE_PATH\"$RESET_COLOR' already exists.' >&2
  else
    mkdir $MINE_PATH
  end

  if test -d $WORK_PATH
    echo -s $PROMPT_ERROR_SIGN'Can\'t create '\
      $PROMPT_PATH_COLOR\"$WORK_PATH\"$RESET_COLOR' folder because '\
      $PROMPT_PATH_COLOR\"$WORK_PATH\"$RESET_COLOR' already exists.' >&2
  else
    mkdir $WORK_PATH
  end
end
