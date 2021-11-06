function __git_prompt --description 'Prints info about .git repo'
  set --query PROMPT_GIT_UNTRACKED_SIGN || set --local PROMPT_GIT_UNTRACKED_SIGN (set_color brred)'✘'(set_color normal)
  set --query PROMPT_GIT_STAGED_SIGN || set --local PROMPT_GIT_STAGED_SIGN (set_color brgreen)'✔'(set_color normal)

  set --query PROMPT_GIT_INCOMING_SIGN || set --local PROMPT_GIT_INCOMING_SIGN (set_color brmagenta)'⬇'(set_color normal)
  set --query PROMPT_GIT_OUTCOMING_SIGN || set --local PROMPT_GIT_OUTCOMING_SIGN (set_color brmagenta)'⬆'(set_color normal)

  set --query PROMPT_GIT_DETACHED_HEAD_SIGN || set --local PROMPT_GIT_DETACHED_HEAD_SIGN (set_color brred)'⌥!'(set_color normal)

  ! test -d .git && return

  set --local UNTRACKED_COUNT (git status --porcelain |\
    string replace --filter --regex '^\?\?\s+(.*)$' '$1' | count)
  set --local STAGED_COUNT (git status --porcelain |\
    string replace --filter --regex '^A\s+(.*)$' '$1' | count)
  
  set --local branch (git branch --show-current)
  test -z "$branch" && set --local branch "$PROMPT_GIT_DETACHED_HEAD_SIGN"

  set --local prompt (string join ' ' \
    (test $UNTRACKED_COUNT -eq 0 && echo -n || echo -n $PROMPT_GIT_UNTRACKED_SIGN':'$UNTRACKED_COUNT)\
    (test $STAGED_COUNT -eq 0 && echo -n || echo -n $PROMPT_GIT_STAGED_SIGN':'$STAGED_COUNT) $branch)

  echo $prompt
end
