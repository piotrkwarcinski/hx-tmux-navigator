(require (prefix-in hx.static. "helix/static.scm"))
(require (prefix-in hx.editor. "helix/editor.scm"))

;;@doc
;; Prevents exiting zoom when the helix pane is zoomed-in.
(define *prevent-zoom-exit* #t)

(define (exec-tmux-move dir)
  (~> (command "tmux" `("select-pane" ,dir)) (spawn-process) (Ok->value) (wait)))

(define (with-stdout-piped command)
  (set-piped-stdout! command)
  command)

;;@doc
;; Returns #t when the current pane is zoomed-in.
(define (exec-tmux-zoomed?)
  (define out (~> (command "tmux" '("display" "-p" "#{window_zoomed_flag}"))
      (with-stdout-piped)
      (spawn-process)
      (Ok->value)
      (wait->stdout)
      (Ok->value)))
  ;; Example output: "0\n"
  ;; thus trim the newline.
  (equal? (substring out 0 1) "1"))

(define (move-tmux dir)
  (exec-tmux-move dir))

(define (move hx-jump-fn tmux-dir-str)
  (begin
  (define view-p (hx.editor.editor-focus))
  (hx-jump-fn)
  (define view-n (hx.editor.editor-focus))
  (if (and (equal? view-n view-p) (not (and *prevent-zoom-exit* (exec-tmux-zoomed?))))
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
  *prevent-zoom-exit*
  move-right
  move-left
  move-down
  move-up)
