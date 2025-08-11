# hx-tmux-navigator

Seamlessly navigate between tmux panes and helix splits.

## Installation

Helix steel plugins are managed using the `forge` package manager which can be installed either by:
* Executing `cargo xtask steel` on [the helix plugin branch](https://github.com/helix-editor/helix/pull/8675) (recommended)
* [Building Steel](https://github.com/mattwparas/steel?tab=readme-ov-file#full-install)

The plugin itself can be installed by using:
```
forge pkg install --git "https://github.com/piotrkwarcinski/hx-tmux-navigator.git"
```

## Configuration
The following allows you to use `C-[hjkl]` to navigate within and between tmux panes and hx splits.

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
```
(require (prefix-in navigator. "hx-tmux-navigator/navigator.scm"))

(keymap (global)
    (insert
      (C-h ":navigator.move-left")
      (C-l ":navigator.move-right")
      (C-j ":navigator.move-down")
      (C-k ":navigator.move-up"))
    (normal
      (C-h ":navigator.move-left")
      (C-l ":navigator.move-right")
      (C-j ":navigator.move-down")
      (C-k ":navigator.move-up")))
```
