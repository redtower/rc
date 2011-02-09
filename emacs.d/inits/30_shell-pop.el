;;=======================================================================
;; @ shell-pop
;;=======================================================================
(require 'shell-pop)
(global-set-key [f8]       'shell-pop)
(global-set-key "\C-c\C-o" 'shell-pop)

(cond ((is_windows)     ; NTEmacs
       (shell-pop-set-internal-mode "eshell")
       (shell-pop-set-internal-mode-shell "bash"))
      ((is_mac)         ; Mac
       (shell-pop-set-internal-mode "ansi-term")
;       (shell-pop-set-internal-mode "eshell")
       (shell-pop-set-internal-mode-shell "/bin/zsh"))
      )

(shell-pop-set-window-height 60)
