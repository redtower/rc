;;=======================================================================
;; @ navi2ch
;;=======================================================================
(add-to-list 'Info-additional-directory-list        ; infoパスの追加
             "~/.emacs.d/elisp/navi2ch/share/info")
(autoload 'navi2ch "navi2ch" "Navigator for 2ch for Emacs" t)
(setq navi2ch-article-auto-range nil)               ; 最初に全件表示する(デフォルトは100)
