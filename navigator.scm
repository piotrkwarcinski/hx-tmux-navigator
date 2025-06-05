(require (prefix-in hx.static. "helix/static.scm"))
(require (prefix-in hx.editor. "helix/editor.scm"))

(define (exec-tmux-move dir)
  (~> (command "tmux" `("select-pane" ,dir)) (spawn-process) (Ok->value) (wait)))

(define (move-tmux dir)
  (exec-tmux-move dir))

(define (move hx-jump-fn tmux-dir-str)
  (begin
  (define view-p (hx.editor.editor-focus))
  (hx-jump-fn)
  (define view-n (hx.editor.editor-focus))
  (if (equal? view-n view-p)
      (move-tmux tmux-dir-str))))

(define (move-right)
  (move hx.static.jump_view_right "-R"))

(define (move-left)
  (move hx.static.jump_view_left "-L"))

(define (move-down)
  (move hx.static.jump_view_down "-D"))

(define (move-up)
  (move hx.static.jump_view_up "-U"))

(provide
  move-right
  move-left
  move-down
  move-up)
