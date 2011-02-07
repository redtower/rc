;;=======================================================================
;; @ 全角空白、Tab、改行表示
;;=======================================================================
(add-to-list 'load-path "~/.emacs.d/elisp/jaspace/")
(require 'jaspace)
(setq jaspace-alternate-jaspace-string "□")
;(setq jaspace-alternate-eol-string "↓\n")
(setq jaspace-highlight-tabs t)
(setq jaspace-modes(mapcar 'car my-fav-modes))
