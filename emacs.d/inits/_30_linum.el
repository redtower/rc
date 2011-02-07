;;=======================================================================
;; @ LineNumbers
;;=======================================================================
(add-to-list 'load-path "~/.emacs.d/elisp/linum/")
(require 'linum)
(global-linum-mode t)                          ; バッファ中の行番号表示
(set-face-attribute                            ; 行番号のフォーマット
 'linum nil :foreground "red" :height 0.8)
(setq linum-format "%4d")
