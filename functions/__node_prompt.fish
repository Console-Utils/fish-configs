function __node_prompt --description 'Prints info about Node version'
  set --query PROMPT_NODE_IDENTIFIER_COLOR || set --local PROMPT_NODE_IDENTIFIER_COLOR (set_color brcyan)

  set --query PROMPT_NODE_SIGN || set --local PROMPT_NODE_SIGN '🔮 '

  set --local CURRENT_DIR $PWD
  set --local not_found true

  set solutions (find -maxdepth 1 -type f -name 'package.json' -print0 | string split0)
  while ! set --query solutions[1]
    if test $PWD != '/'
      cd ..
      set solutions (find -maxdepth 1 -type f -name 'package.json' -print0 | string split0)
    else
      set not_found false
      break
    end
  end

  if test $not_found = false
    cd $CURRENT_DIR
    return
  end

  set --local PROMPT $PROMPT_NODE_SIGN

  if command --query --search node
    set --local NODE_VERSION (node --version)
    string match --regex --quiet '^v(?<MAJOR_VERSION>\d+)\.(?<MINOR_VERSION>\d+).*' $NODE_VERSION
    set PROMPT $PROMPT$PROMPT_NODE_IDENTIFIER_COLOR"node $MAJOR_VERSION.$MINOR_VERSION$RESET_COLOR"
  else
    set PROMPT
  end

  echo -n $PROMPT
  cd $CURRENT_DIR
end
