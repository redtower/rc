;;=======================================================================
;; @ 全角空白、Tab、改行表示
;;=======================================================================
(require 'jaspace)
(setq jaspace-alternate-jaspace-string "□")
;(setq jaspace-alternate-eol-string "↓\n")
(setq jaspace-highlight-tabs t)
(setq jaspace-modes(mapcar 'car my-fav-modes))
