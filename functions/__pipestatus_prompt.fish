function __pipestatus_prompt --description 'Prints $pipestatus in human-readable format'
  set --local statuses $argv

  set --query PROMPT_PIPESTATUS_BRACKET_COLOR || set --local PROMPT_PIPESTATUS_BRACKET_COLOR (set_color red)
  set --query PROMPT_PIPESTATUS_STATUS_COLOR || set --local PROMPT_PIPESTATUS_STATUS_COLOR (set_color brred)
  set --query PROMPT_PIPESTATUS_DELIMITER_COLOR || set --local PROMPT_PIPESTATUS_DELIMITER_COLOR (set_color purple)

  echo -n $PROMPT_PIPESTATUS_BRACKET_COLOR'['

  for i in (seq 1 (count $statuses))
    echo -n $PROMPT_PIPESTATUS_STATUS_COLOR$statuses[$i]
    test $i -lt (count $statuses) && echo -n $PROMPT_PIPESTATUS_DELIMITER_COLOR'|'
  end

  echo -n $PROMPT_PIPESTATUS_BRACKET_COLOR']'
end
