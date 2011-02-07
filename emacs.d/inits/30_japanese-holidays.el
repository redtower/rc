;;=======================================================================
;; @ japanese-holidays.el
;;=======================================================================
(add-to-list 'load-path "~/.emacs.d/elisp/japanese-holidays")
(add-hook 'calendar-load-hook
          (lambda ()
            (require 'japanese-holidays)
            (setq calendar-holidays
                  (append japanese-holidays local-holidays other-holidays))))
