;;=======================================================================
;; @ csharp-mode（c#）
;;=======================================================================
(add-to-list 'load-path "~/.emacs.d/elisp/csharp-mode")
(autoload 'csharp-mode "csharp-mode" "Major mode for editing C# code." t)
(setq auto-mode-alist
      (cons '("\\.cs$" . csharp-mode) auto-mode-alist))

;; Patterns for finding Microsoft C# compiler error messages:
(require 'compile)
(push '("^\\(.*\\)(\\([0-9]+\\),\\([0-9]+\\)): error"   1 2 3 2) compilation-error-regexp-alist)
(push '("^\\(.*\\)(\\([0-9]+\\),\\([0-9]+\\)): warning" 1 2 3 1) compilation-error-regexp-alist)

;; Patterns for defining blocks to hide/show:
(push '(csharp-mode
        "\\(^\\s *#\\s *region\\b\\)\\|{"
        "\\(^\\s *#\\s *endregion\\b\\)\\|}"
        "/[*/]"
        nil
        hs-c-like-adjust-block-beginning)
      hs-special-modes-alist)
