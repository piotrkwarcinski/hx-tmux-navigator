### hx-tmux-navigator

Seamleassly navigate between tmux panes and helix splits.

### Configuration
* Add the following to `tmux.conf`
```
is_hx="ps -o state= -o comm= -t '#{pane_tty}' \
    | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?hx?x?|fzf)(diff)?$'"
bind-key -n 'C-h' if-shell "$is_hx" 'send-keys C-h'  'select-pane -L'
bind-key -n 'C-j' if-shell "$is_hx" 'send-keys C-j'  'select-pane -D'
bind-key -n 'C-k' if-shell "$is_hx" 'send-keys C-k'  'select-pane -U'
bind-key -n 'C-l' if-shell "$is_hx" 'send-keys C-l'  'select-pane -R'
```
* Configure bindings in `init.scm`
