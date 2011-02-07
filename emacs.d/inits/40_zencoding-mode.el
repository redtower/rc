;;=======================================================================
;; @ zencoding-mode
;;=======================================================================
(require 'zencoding-mode) 
(add-hook 'sgml-mode-hook 'zencoding-mode) ; html-modeとかで自動出来にzencodingできるようにする
(define-key zencoding-mode-keymap    (kbd "C-c C-n") 'zencoding-expand-line)
(define-key zencoding-preview-keymap (kbd "C-c C-n") 'zencoding-preview-accept)
