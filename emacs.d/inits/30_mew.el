;;=======================================================================
;; @ Mew
;;=======================================================================
(cond
 ((is_windows)
  (autoload 'mew "mew" nil t)
  (autoload 'mew-send "mew" nil t)

  ;; Optional setup (Read Mail menu):
  (setq read-mail-command 'mew)
  (setq mew-use-unread-mark t)          ; 未読マーク（U）をつける

  ;; Optional setup (e.g. C-xm for sending a message):
  (autoload 'mew-user-agent-compose "mew" nil t)
  (if (boundp 'mail-user-agent)
      (setq mail-user-agent 'mew-user-agent))
  (if (fboundp 'define-mail-user-agent)
      (define-mail-user-agent
        'mew-user-agent
        'mew-user-agent-compose
        'mew-draft-send-message
        'mew-draft-kill
        'mew-send-hook))

  (setq mew-use-cached-passwd t)))
