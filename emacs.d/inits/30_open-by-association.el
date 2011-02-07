;;=======================================================================
;; @ 関連付けから外部プログラムを起動する
;;     ref. http://k4zmblog.dtiblog.com/blog-entry-153.html
;;     ref. http://d.hatena.ne.jp/sr10/20110118/1295280250
;;     ref. http://d.hatena.ne.jp/cast_everything/20091125/1259141356
;;=======================================================================
(defun uenox-dired-winstart ()
  "Type '[uenox-dired-winstart]': win-start the current line's file."
  (interactive)
  (if (eq major-mode 'dired-mode)
      (let ((fname (dired-get-filename)))
        (cond ((is_windows)
               (w32-shell-execute "open" fname)
               (message "win-started %s" fname))
              ((is_mac)
               (call-process-shell-command (concat "open \"" fname "\""))
               (message "opening... %s" fname))
               )
              )))
;;; dired のキー割り当て追加
(add-hook 'dired-mode-hook
          (lambda ()
            (define-key dired-mode-map "z" 'uenox-dired-winstart))) ;; キーバインド 
