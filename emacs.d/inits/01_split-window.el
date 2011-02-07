;;=======================================================================
;; @ Window
;;=======================================================================
;; 分割したウィンドウ間を移動
(define-prefix-command 'windmove-map)
(global-set-key (kbd "C-o") 'windmove-map)
(define-key windmove-map "h" 'windmove-left)
(define-key windmove-map "j" 'windmove-down)
(define-key windmove-map "k" 'windmove-up)
(define-key windmove-map "l" 'windmove-right)
(define-key windmove-map "0" 'delete-window)
(define-key windmove-map "1" 'delete-other-windows)
(define-key windmove-map "2" 'split-window-vertically)
(define-key windmove-map "3" 'split-window-horizontally)

;; windowを分割・削除したときに幅をあわせる＋別のwindowに移動
;(defadvice-many (split-window-vertically
;                 split-window-horizontally
;                 delete-window) after
;  (balance-windows)
;  (other-window 1))
(defun split-window-conditional ()
  (interactive)
  (if (> (* (window-height) 2) (window-width))
      (split-window-vertically)
    (split-window-horizontally)))
(define-key windmove-map "s" 'split-window-conditional)
(define-key windmove-map "n"
  (lambda ()
    (interactive)
    (split-window-conditional)
    (switch-to-buffer "*scratch*")))

