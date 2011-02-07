;;=======================================================================
;; @ Darkroom-mode
;;=======================================================================
(require 'darkroom-mode)
(defun toggle-darkroom ()
  (interactive)
;  (global-linum-mode nil)
  (darkroom-mode))
(global-set-key (kbd "C-c d") 'toggle-darkroom)
