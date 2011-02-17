;; shell の存在を確認
(defun skt:shell ()
  (or (executable-find "zsh")
      ;; (executable-find "bash")
      ;; (executable-find "f_zsh") ;; Emacs + Cygwin を利用する人は Zsh の代りにこれにしてください
      ;; (executable-find "f_bash") ;; Emacs + Cygwin を利用する人は Bash の代りにこれにしてください
      (executable-find "cmdproxy")
      (error "can't find 'shell' command in PATH!!")))

;; Shell 名の設定
(setq shell-file-name (skt:shell))
(setenv "SHELL" shell-file-name)
(setq explicit-shell-file-name shell-file-name)

;;=======================================================================
;; @ shell-pop
;;=======================================================================
(require 'shell-pop)
(global-set-key [f8]       'shell-pop)
(global-set-key "\C-c\C-o" 'shell-pop)

(cond ((is_windows)     ; NTEmacs
       (shell-pop-set-internal-mode "shell")
       (shell-pop-set-internal-mode-shell "zsh"))
      ((is_mac)         ; Mac
       (shell-pop-set-internal-mode "shell")
;       (shell-pop-set-internal-mode "ansi-term")
;       (shell-pop-set-internal-mode "eshell")
       (shell-pop-set-internal-mode-shell "/bin/zsh"))
      )

(shell-pop-set-window-height 30)

;;=======================================================================
;; @ shell-toggle
;;=======================================================================
(autoload 'shell-toggle "shell-toggle"
  "Toggles between the *shell* buffer and whatever buffer you are editing."
  t)
(autoload 'shell-toggle-cd "shell-toggle"
  "Pops up a shell-buffer and insert a \"cd \" command." t)
(global-set-key [f9]       'shell-toggle-cd)