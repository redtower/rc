;;=======================================================================
;; @ load-path
;;=======================================================================
(add-to-list 'load-path "~/.emacs.d/elisp/howm/")
(add-to-list 'load-path "~/.emacs.d/elisp/calfw")
(add-to-list 'load-path "~/.emacs.d/elisp/clmemo/")
(add-to-list 'load-path "~/.emacs.d/elisp/emacs-w3m/share/emacs/site-lisp/w3m/")
(add-to-list 'load-path "~/.emacs.d/elisp/navi2ch/share/emacs/site-lisp/")

;;=======================================================================
;; @ init-loader
;;=======================================================================
(add-to-list 'load-path "~/.emacs.d/elisp/init-loader/")
(require 'init-loader)
(init-loader-load "~/.emacs.d/inits")

;;=======================================================================
;; @ load private-emacs.el
;;=======================================================================
(load "~/rc/private/emacs.el" :if-does-not-exist nil)

;;======================================================================
;; @ ホームディレクトリに移動する
;;=======================================================================
(cd "~")

