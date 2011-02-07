;;=======================================================================
;; @ color-theme
;;=======================================================================
(add-to-list 'load-path "~/.emacs.d/elisp/color-theme/")

(when window-system
  (require 'color-theme)
  (color-theme-initialize)
;  (color-theme-dark-blue2)   ; Dark Blue2
  (color-theme-arjen)        ; Arjen
)