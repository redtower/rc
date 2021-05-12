
function t()
{
  create_new_session="Create New Session"
  ID="`tmux list-sessions | sort -r`\n${create_new_session}:"

  ID="`echo $ID | peco | cut -d: -f1`"
  if [[ "$ID" = "${create_new_session}" ]]; then
    #tmux new-session
    tmux new-session \; source-file ~/.tmux/new-session
  elif [[ -n "$ID" ]]; then
    tmux attach-session -t "$ID"
  else
    :  # Start terminal normally
  fi
}

if [[ ! -n $TMUX && $- == *l* ]]; then
  # get the IDs
  ID="`tmux list-sessions`"
  if [[ -z "$ID" ]]; then
    #tmux new-session
    tmux new-session \; source-file ~/.tmux/new-session
  fi

  t
fi

