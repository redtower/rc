;;=======================================================================
;; @ markdown-mode
;;=======================================================================
(autoload 'markdown-mode "markdown-mode.el"
   "Major mode for editing Markdown files" t)
(setq auto-mode-alist
   (cons '("\\.\\(md\\|markdown\\)" . markdown-mode) auto-mode-alist))

;; markdown-modeで利用するコマンド
(cond ((is_windows) (setq markdown-command "/usr/local/bin/markdown")))
