;;=======================================================================
;; @ LineNumbers
;;=======================================================================
(require 'linum)
(global-linum-mode t)                          ; バッファ中の行番号表示
(set-face-attribute                            ; 行番号のフォーマット
 'linum nil :foreground "hotpink" :height 1.0)
(setq linum-format "%4d")
