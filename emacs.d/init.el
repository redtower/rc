;;=======================================================================
;; @ load-path
;;=======================================================================
(add-to-list 'load-path "~/.emacs.d/elisp/howm")
(add-to-list 'load-path "~/.emacs.d/elisp/calfw")
(add-to-list 'load-path "~/.emacs.d/elisp/clmemo")
;(add-to-list 'load-path "~/.emacs.d/elisp/gtags")
(add-to-list 'load-path "~/.emacs.d/elisp/auto-install")
(add-to-list 'load-path "~/.emacs.d/elisp/auto-complete")
(add-to-list 'load-path "~/.emacs.d/elisp/emacs-w3m/share/emacs/site-lisp/w3m")
(add-to-list 'load-path "~/.emacs.d/elisp/navi2ch/share/emacs/site-lisp")
(add-to-list 'load-path "~/.emacs.d/elisp/init-loader")
(add-to-list 'load-path "~/.emacs.d/elisp/bf-mode")
(add-to-list 'load-path "~/.emacs.d/elisp/color-moccur")
(add-to-list 'load-path "~/.emacs.d/elisp/moccur-edit")
(add-to-list 'load-path "~/.emacs.d/elisp/color-theme")
(add-to-list 'load-path "~/.emacs.d/elisp/dabbrev")
(add-to-list 'load-path "~/.emacs.d/elisp/darkroom-mode")
(add-to-list 'load-path "~/.emacs.d/elisp/japanese-holidays")
(add-to-list 'load-path "~/.emacs.d/elisp/mew")
(add-to-list 'load-path "~/.emacs.d/elisp/shell-pop")
(add-to-list 'load-path "~/.emacs.d/elisp/tumble")
(add-to-list 'load-path "~/.emacs.d/elisp/yasnippet")
(add-to-list 'load-path "~/.emacs.d/elisp/anything")
(add-to-list 'load-path "~/.emacs.d/elisp/yen")
(add-to-list 'load-path "~/.emacs.d/elisp/zencoding-mode")
(add-to-list 'load-path "~/.emacs.d/elisp/csharp-mode")
(add-to-list 'load-path "~/.emacs.d/elisp/markdown-mode")
(add-to-list 'load-path "~/.emacs.d/elisp/wp-emacs")
;(add-to-list 'load-path "~/.emacs.d/elisp/linum")
(add-to-list 'load-path "~/.emacs.d/elisp/jaspace")
(add-to-list 'load-path "~/.emacs.d/elisp/imcap")
(add-to-list 'load-path "~/.emacs.d/elisp/window-layout")
;(add-to-list 'load-path "~/.emacs.d/elisp/e2wm")
(add-to-list 'load-path "~/.emacs.d/elisp/shell-toggle")
(add-to-list 'load-path "~/.emacs.d/elisp/elscreen")
(add-to-list 'load-path "~/.emacs.d/elisp/elscreen-howm")
(add-to-list 'load-path "~/.emacs.d/elisp/elscreen-dired")
(add-to-list 'load-path "~/.emacs.d/elisp/elscreen-w3m")
(add-to-list 'load-path "~/.emacs.d/elisp/elscreen-color-theme")
(add-to-list 'load-path "~/.emacs.d/elisp/apel")

;;=======================================================================
;; @ init-loader
;;=======================================================================
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

