;;=======================================================================
;; @ key bind
;;=======================================================================
(global-set-key   "\C-c\C-e" 'eval-current-buffer)    ; .emacs再読込
(global-unset-key "\C-x\C-u")                         ; C-x C-u が何もしないように変更する
                                                      ;     （undo の typo 時誤動作防止）
(define-key global-map (kbd "C-5") 'show-paren-mode)  ; 括弧の対応を見るモードを C-5 でトグルする。
(global-set-key "\C-z" 'undo)                         ; undo
(global-set-key "\M-s" 'query-replace-regexp)         ; 文字列置換
;(global-set-key "\C-m" 'reindent-then-newline-and-indent) ; 改行キーでオートインデント

;;=======================================================================
;; @ Command-Key and Option-Key Reverse
;;=======================================================================
(when (is_mac)
  (setq ns-command-modifier        'meta)
  (setq ns-alternate-modifier      'super)
  (setq mac-pass-command-to-system  nil))

;;=======================================================================
;; @ Move Cursor
;;=======================================================================
(global-set-key "\C-h"      'backward-delete-char)  ; C-h でバックスペース
;(global-set-key "\C-h"      'backward-char)         ; ←
;(global-set-key "\C-j"      'next-line)             ; ↓
;(global-set-key "\C-k"      'previous-line)         ; ↑
;(global-set-key "\C-l"      'forward-char)          ; →
;(global-set-key "\C-n"      'newline-and-indent)    ; 改行してインデント
;(global-set-key "\C-o"      'kill-line)             ; 行削除(C-kの代わり)
;(global-set-key (kbd "C-'") 'recenter)              ; カーソル位置を画面中央に(C-lの代わり)
(define-key global-map "\C-t" 'other-window)         ; Window移動

;;=======================================================================
;; @ カーソル位置の単語を削除(M-d)
;;=======================================================================
(defun kill-word-at-point ()
  (interactive)
  (let ((char (char-to-string (char-after (point)))))
    (cond
     ((string= " " char) (delete-horizontal-space))
     ((string-match "[\t\n -@\[-`{-~]" char) (kill-word 1))
     (t (forward-char) (backward-word) (kill-word 1)))))
(global-set-key "\M-d" 'kill-word-at-point)

;;=======================================================================
;; @ コメントアウト
;;=======================================================================
(global-set-key "\C-x;" 'comment-region)              ; コメントアウト
(global-set-key "\C-x:" 'uncomment-region)            ; コメント解除

;;=======================================================================
;; @ クリップボードと共有する
;;   ref. http://d.hatena.ne.jp/x68kace/20080317/p3
;;=======================================================================
(global-unset-key "\C-y")
(global-set-key   "\C-y" 'clipboard-yank)
(global-unset-key "\C-w")
(global-set-key   "\C-w" 'clipboard-kill-region)
(global-unset-key "\M-w")
(global-set-key   "\M-w" 'clipboard-kill-ring-save)

;;=======================================================================
;; @ バッファリストの置き換え（bs）
;;=======================================================================
(global-set-key [?\C-,]    'bs-cycle-next)
(global-set-key [?\C-.]    'bs-cycle-previous)
