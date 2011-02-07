;;=======================================================================
;; @ タグジャンプ（etags M-. M-*）
;;=======================================================================
(defadvice find-tag (before c-tag-file activate)
  "Automatically create tags file."
  (let ((tag-file (concat default-directory "TAGS")))
    (unless (file-exists-p tag-file)
      (shell-command "etags *.[ch] *.cs *.el .*.el -o TAGS 2>/dev/null"))
    (visit-tags-table tag-file)))

;;=======================================================================
;; @ GNU GLOBAL（gtags）
;;=======================================================================
(add-to-list 'load-path "~/.emacs.d/elisp/gtags/")
(autoload 'gtags-mode "gtags" "" t)
(setq gtags-mode-hook
      '(lambda ()
         (local-set-key "\M-t" 'gtags-find-tag)
         (local-set-key "\M-r" 'gtags-find-rtag)
         (local-set-key "\M-s" 'gtags-find-symbol)
         (local-set-key "\C-t" 'gtags-pop-stack)
         ))
