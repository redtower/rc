;;=======================================================================
;; @ emacs-w3m
;;=======================================================================
(add-to-list 'load-path                             ; loadパスの追加
             "~/.emacs.d/elisp/emacs-w3m/share/emacs/site-lisp/w3m/")
(add-to-list 'Info-additional-directory-list        ; infoパスの追加
             "~/.emacs.d/elisp/emacs-w3m/share/info")
(require 'w3m-load)

(defun browse-url-default-macosx-browser (url &optional new-window)
  (interactive (browse-url-interactive-arg "URL: "))
  (if (and new-window (>= emacs-major-version 23))
      (ns-do-applescript
       (format
        (concat "tell application \"Safari\" to make document with properties {URL:\"%s\"}\n"
                "tell application \"Safari\" to activate") url))
    (start-process (concat "open " url) nil "open" url)))

(if (is_windows)
    (setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program
      (w32-short-file-name "C:/Program Files/Mozilla Firefox/firefox.exe")) )

(defun choose-browser (url &rest args)
  (interactive "sURL: ")
  (if (y-or-n-p "Use external browser? ")
      (cond
       ((is_mac)     (browse-url-default-macosx-browser url))
       ((is_windows) (browse-url-generic url)))
      (w3m-browse-url url)))
(setq browse-url-browser-function 'choose-browser)
(global-set-key "\C-xm" 'browse-url-at-point)       ; カーソル位置の文字列をURLとしてブラザを起動する

;;=======================================================================
;; @ ttp で始まる URL を http として認識させる。
;;   ref. http://www.bookshelf.jp/soft/meadow_55.html#SEC829
;;=======================================================================
;; for browse-url-at-mouse
(setq thing-at-point-url-regexp
      (concat
       "\\<\\(h?ttps?://\\|ftp://\\|gopher://\\|telnet://"
       "\\|wais://\\|file:/\\|s?news:\\|mailto:\\)"
       thing-at-point-url-path-regexp))
(defadvice thing-at-point-url-at-point (after support-omitted-h activate)
  (when (and ad-return-value (string-match "\\`ttps?://" ad-return-value))
    (setq ad-return-value (concat "h" ad-return-value))))

;; for emacs-w3m
(setq ffap-url-regexp
      (concat
       "\\`\\("
       "news\\(post\\)?:\\|mailto:\\|file:"
       "\\|"
       "\\(ftp\\|h?ttps?\\|telnet\\|gopher\\|www\\|wais\\)://"
       "\\)."))
(defadvice ffap-url-at-point (after support-omitted-h activate)
  (when (and ad-return-value (string-match "\\`ttps?://" ad-return-value))
    (setq ad-return-value (concat "h" ad-return-value))))

;; for SEMI
(setq mime-browse-url-regexp
      (concat "\\(h?ttps?\\|ftp\\|file\\|gopher\\|news\\|telnet\\|wais\\|mailto\\):"
              "\\(//[-a-zA-Z0-9_.]+:[0-9]*\\)?"
              "[-a-zA-Z0-9_=?#$@~`%&*+|\\/.,]*[-a-zA-Z0-9_=#$@~`%&*+|\\/]"))
(defadvice browse-url (before support-omitted-h (url &rest args) activate)
  (when (and url (string-match "\\`ttps?://" url))
    (setq url (concat "h" url))))

