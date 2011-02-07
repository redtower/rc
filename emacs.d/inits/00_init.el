;;=======================================================================
;; @ os check function
;;=======================================================================
(defun is_windows () (eq system-type 'windows-nt))      ; Windows
(defun is_mac     () (member window-system '(mac ns)))  ; Mac
(defun is_linux   () (eq window-system 'x))             ; Linux

;=======================================================================
; my-fav-modes
;=======================================================================
(defvar my-fav-modes
  '((emacs-lisp-mode    . "\\.el$")
    (common-lisp-mode   . "\\.\\(cl\\|lisp\\)$")
    (scheme-mode        . "\\.scm$")
    (clojure-mode       . "\\.clj$")
    (pir-mode           . "\\.\\(imc\\|pir\\)$")
    (malabar-mode       . "\\.java$")
    (php-mode           . "\\.php[45]?$")
    (yaml-mode          . "\\.ya?ml$")
    (js2-mode           . "\\.js$")
    (ruby-mode          . "\\.rb$")
    (text-mode          . "\\.txt$")
    (fundamental-mode   . nil)
    (LaTeX-mode         . "\\.tex$")
    (org-mode           . "\\.org$")
    (css-mode           . "\\.css$")
    (nxml-mode          . "\\.\\(xml\\|svg\\|wsdl\\|xslt\\|wsdd\\|xsl\\|rng\\|xhtml\\|jsp\\|tag\\)$")
    (howm-mode          . "\\.howm$")
    (markdown-mode      . "\\.\\(md\\|markdown\\)$")
    (csharp-mode        . "\\.cs$")
))

;=======================================================================
; path
;=======================================================================
;; より下に記述した物が PATH の先頭に追加されます
(dolist (dir (list
              "/sbin"
              "/usr/sbin"
              "/bin"
              "/usr/bin"
              "/usr/local/bin"
              (expand-file-name "~/bin")
              (expand-file-name "~/.emacs.d/elisp/darkroom-mode")
              (expand-file-name "~/.emacs.d/elisp/mew/bin")
              (expand-file-name "~/rc/emacs.d/bin")
              ))
 ;; PATH と exec-path に同じ物を追加します
  (when (and (file-exists-p dir) (not (member dir exec-path)))
    (setenv "PATH" (concat dir ":" (getenv "PATH")))
    (setq exec-path (append (list dir) exec-path))))
