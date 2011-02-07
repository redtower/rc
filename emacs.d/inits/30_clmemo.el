;;=======================================================================
;; @ clmemo.el
;;=======================================================================
(add-to-list 'load-path "~/.emacs.d/elisp/clmemo/")
(autoload 'clmemo "clmemo" "ChangeLog memo mode." t)
(setq clmemo-file-name "~/rc/private/clmemo.txt")
(global-set-key "\C-xM" 'clmemo)
