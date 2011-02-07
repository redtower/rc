;;=======================================================================
;; @ auto-complete（補完候補を自動ポップアップ）
;;=======================================================================
(add-to-list 'load-path "~/.emacs.d/elisp/auto-complete/")
(require 'auto-complete)
(global-auto-complete-mode t)
;(setq ac-modes (cons 'js-mode ac-modes))
(setq ac-modes (mapcar 'car my-fav-modes))
