function fish_prompt
  set --local statuses $pipestatus

  set --local user_char '💲'
  fish_is_root_user && set user_char '⭐💲'

  echo -s (set_color yellow) (__cwd_prompt) (__pipestatus_prompt $statuses) $user_char
end
