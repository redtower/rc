;;=======================================================================
;; @ 動的略語補完 dabbrev-ja
;;=======================================================================
(add-to-list 'load-path "~/.emacs.d/elisp/dabbrev/")
(load "dabbrev-ja")
(global-set-key "\C-j" 'dabbrev-completion) ; デフォルトはM-/
(setq dabbrev-case-fold-search nil)         ; 大文字小文字を区別
