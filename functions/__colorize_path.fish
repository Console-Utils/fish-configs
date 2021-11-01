function __colorize_path --description 'Colorizes path'
  set --local directory $argv[1]

  set --query PROMPT_PATH_PATH_COLOR || set --local PROMPT_PATH_PATH_COLOR (set_color brcyan)
  set --query PROMPT_PATH_DELIMITER_COLOR || set --local PROMPT_PATH_DELIMITER_COLOR (set_color brblue)

  set --local MINE_COLOR (set_color --bold)
  set --local WORK_COLOR (set_color --bold)
  
  set --local directory (string replace --regex '(\$MINE_PATH)' "$MINE_COLOR"'🏠$1'"$RESET_COLOR" $directory)
  set --local directory (string replace --regex '(\$WORK_PATH)' "$WORK_COLOR"'🏢$1'"$RESET_COLOR" $directory)

  set --local directory $PROMPT_PATH_PATH_COLOR$directory
  set --local directory (string replace --regex --all '/' "$PROMPT_PATH_DELIMITER_COLOR"'/'"$PROMPT_PATH_PATH_COLOR" $directory)
  set --local directory $directory$RESET_COLOR

  echo $directory
end
