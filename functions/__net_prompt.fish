function __net_prompt --description 'Prints info about .NET/Mono version'
  set --query PROMPT_NET_SIGN || set --local PROMPT_NET_SIGN '🔮 '

  set --local CURRENT_DIR $PWD
  set --local not_found true
  while ! test -f .sln
    if test $PWD != '/'
      cd ..
    else
      set not_found false
      break
    end
  end

  if test $not_found = false
    cd $CURRENT_DIR
    return
  end

  set --local PROMPT $PROMPT_NET_SIGN

  if command --query --search mono
    set PROMPT $PROMPT'mono '(mono --version | awk 'NR == 1 { print $5 }')
  else if command --query --search dotnet
    set PROMPT $PROMPT'dotnet '(dotnet --version)
  end

  echo $PROMPT
  cd $CURRENT_DIR
end
