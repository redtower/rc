
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
function ide()
{
# set tmux panes for ide
    if [ "$#" -eq 0 ]; then
      tmux split-window -v
      tmux split-window -h
      tmux resize-pane -D 15
      tmux select-pane -t 1
    else
      case $1 in
        1)
          tmux split-window -v
          tmux select-pane -t 1
          tmux split-window -h
          tmux split-window -h
          #tmux resize-pane -D 15
          #tmux select-pane -D
          clear
          ;;
        2)
          tmux split-window -v
          tmux split-window -h
          tmux resize-pane -D 15
          tmux select-pane -t 1
          tmux split-window -v
          tmux select-pane -t 1
          clear
          ;;
        py)
          cd ~/workspace
          tmux split-window -v
          tmux split-window -h
          tmux resize-pane -D 15
          tmux select-pane -t 1
          vi .
          clear
          ;;
        *)
          echo [ERROR] "$1" は設定されていない引数です。
          ;;
      esac
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

