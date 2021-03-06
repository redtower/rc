;;=======================================================================
;; @ emacs-w3m
;;=======================================================================
(add-to-list 'Info-additional-directory-list        ; infoパスの追加
             "~/.emacs.d/elisp/emacs-w3m/share/info")
(require 'w3m-load)

;;=======================================================================
;; @ 外部ブラウザの起動（C-x m）
;;=======================================================================
(defun browse-url-default-macosx-browser (url &optional new-window)
  (interactive (browse-url-interactive-arg "URL: "))
  (if (and new-window (>= emacs-major-version 23))
      (ns-do-applescript
       (format
        (concat "tell application \"Safari\" to make document with properties {URL:\"%s\"}\n"
                "tell application \"Safari\" to activate") url))
    (start-process (concat "open " url) nil "open" url)))

(defun my-external-browser (url &rest args) ; 外部ブラウザ
  (cond
   ((is_mac)     (browse-url-default-macosx-browser url))
   ((is_windows) (browse-url-default-windows-browser url))))

(defun choose-browser (url &rest args)      ; ブラウザ選択
  (interactive "sURL: ")
  (if (y-or-n-p "Use external browser? ")
      (my-external-browser url)             ; 外部ブラウザ
      (w3m-browse-url url)))                ; emacs-w3m

(setq browse-url-dhtml-url-list             ; Emacs-w3m で見られない URL のブラックリスト
      '("http://www.google.com/reader"
        "http://www.google.co.jp/reader"
        "http://maps.google.co.jp"
        "http://map.yahoo.co.jp"
        "http://map.labs.goo.ne.jp"
        "http://www.haloscan.com"
        "http://sitemeter.com"
        "http://www.hmv.co.jp"
))

(setq browse-url-browser-function           ; ブラックリストにマッチしたら外部ブラウザ
      `((,(concat "^" (regexp-opt browse-url-dhtml-url-list)) . my-external-browser)
        ("." . choose-browser)))

(global-set-key "\C-xm" 'browse-url-at-point)   ; カーソル位置の文字列をURLとしてブラウザを起動する

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

