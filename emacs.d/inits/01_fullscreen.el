;;=======================================================================
;; @ fullscreen
;;=======================================================================
(defun toggle-fullscreen ()
  (interactive)
  (cond
   ((is_mac)     (ns-toggle-fullscreen))
   ((is_windows) (w32-fullscreen))
   ((is_linux)   (if (frame-parameter nil 'fullscreen)
                     (set-frame-parameter nil 'fullscreen nil)
                     (set-frame-parameter nil 'fullscreen 'fullboth)))))
(global-set-key (kbd "C-c m") 'toggle-fullscreen)
