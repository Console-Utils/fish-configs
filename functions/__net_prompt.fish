function __net_prompt --description 'Prints info about .NET/Mono version'
  set --query PROMPT_NET_FRAMEWORK_IDENTIFIER_COLOR || set --local PROMPT_NET_FRAMEWORK_IDENTIFIER_COLOR (set_color brcyan)
  set --query PROMPT_NET_VERSION_COLOR || set --local PROMPT_NET_VERSION_COLOR (set_color cyan)

  set --query PROMPT_NET_SIGN || set --local PROMPT_NET_SIGN (set_color cyan)'❰'$RESET_COLOR

  set --local CURRENT_DIR $PWD
  set --local not_found true

  set solutions (find -maxdepth 1 -type f -name '*.sln' -print0 | string split0)
  while ! set --query solutions[1]
    if test $PWD != '/'
      cd ..
      set solutions (find -maxdepth 1 -type f -name '*.sln' -print0 | string split0)
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
    set --local MONO_VERSION (mono --version | awk 'NR == 1 { print $5 }')
    string match --regex --quiet '^(?<MAJOR_VERSION>\d+)\.(?<MINOR_VERSION>\d+).*' $MONO_VERSION
    set PROMPT $PROMPT$PROMPT_NET_FRAMEWORK_IDENTIFIER_COLOR'mono '$PROMPT_NET_VERSION_COLOR$MAJOR_VERSION.$MINOR_VERSION$RESET_COLOR
  else if command --query --search dotnet
    set --local DOTNET_VERSION (dotnet --version)
    string match --regex --quiet '^(?<MAJOR_VERSION>\d+)\.(?<MINOR_VERSION>\d+).*' $DOTNET_VERSION
    set PROMPT $PROMPT$PROMPT_NET_FRAMEWORK_IDENTIFIER_COLOR'dotnet '$PROMPT_NET_VERSION_COLOR$MAJOR_VERSION.$MINOR_VERSION$RESET_COLOR
  else
    set PROMPT
  end

  echo -n $PROMPT
  cd $CURRENT_DIR
end
