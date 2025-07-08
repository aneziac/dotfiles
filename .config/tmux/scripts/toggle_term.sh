#!/bin/zsh

current_cmd="$(tmux display-message -p "#{pane_current_command}")"
current_win="$(tmux display-message -p "#{window_id}")"
current_pane="$(tmux display-message -p "#{pane_id}")"

term_pane=$(tmux list-panes -F "#{window_id}:#{pane_id}:#{pane_title}" \
  | grep "^$current_win:" \
  | grep "term-pane$" \
  | grep -v "^$current_win:$current_pane" \
  | cut -d: -f2)

if [ "$current_cmd" = "nvim" ] && [ -n "$term_pane" ]; then
  tmux kill-pane -t "$term_pane"
elif [ "$current_cmd" = "nvim" ] && [ -z "$term_pane" ]; then
  tmux split-window -v -l 15
  tmux select-pane -T term-pane
elif [ "$current_cmd" != "nvim" ] && [ "$(tmux display-message -p "#{pane_title}")" = "term-pane" ]; then
  tmux kill-pane -t "$current_pane"
fi

