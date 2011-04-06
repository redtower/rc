;;=======================================================================
;; @ frame size
;;=======================================================================
(when window-system
  (setq initial-frame-alist
        (append
         '((width  . 105)   ; フレーム幅(文字数)
           (height . 42))   ; フレーム高(文字数)
         initial-frame-alist))
  (setq default-frame-alist
        (append
         '((width  . 105)   ; フレーム幅(文字数)
           (height . 42))   ; フレーム高(文字数)
         default-frame-alist))
)

;;=======================================================================
;; @ frame
;;=======================================================================
;; (setq frame-title-format                        ; フレームのタイトル指定
;;       (concat "%b - emacs@" system-name " - " system-configuration))

;;=======================================================================
;; @ modeilne
;;=======================================================================
(line-number-mode t)                            ; 行番号を表示
(column-number-mode t)                          ; 桁番号を表示
(setq display-time-string-forms                 ; 時刻の表示フォーマット設定
      '(24-hours ":" minutes))
(display-time)                                  ; 時刻を表示
(setq eol-mnemonic-dos  "(CRLF)"                ; 改行コードを表示
      eol-mnemonic-mac  "(CR)"
      eol-mnemonic-unix "(LF)")

;;=======================================================================
;; @ cursor
;;=======================================================================
(blink-cursor-mode 0)                           ; カーソル点滅表示
(setq scroll-preserve-screen-position t)        ; スクロール時のカーソル位置の維持
(setq vertical-centering-font-regexp ".*"       ; 1行ずつスクロール
      scroll-conservatively 35
      scroll-margin 0
      scroll-step 1)

(setq next-screen-context-lines 1)              ; 画面スクロール時の重複行数
(setq comint-scroll-show-maximum-output t)      ; for shell-mode

;;=======================================================================
;; @ misc
;;=======================================================================
(when window-system
    (mouse-wheel-mode t)                        ; ホイールマウス（あり）
    (set-scroll-bar-mode 'right)                ; スクロールバーを右に表示
    (tool-bar-mode 0)                           ; ツールバー表示なし
    (cond
     ((is_mac)
      (set-frame-parameter nil 'alpha 90)))     ; フレームを透過
)
(cond ((is_mac)     (menu-bar-mode t))          ; メニューバー表示あり
      ((is_windows) (menu-bar-mode t))          ; メニューバー表示あり
      (t            (menu-bar-mode nil)))       ; メニューバー表示なし
(global-font-lock-mode t)                       ; 文字の色つけ

;;=======================================================================
;; @ generic
;;=======================================================================
(require 'generic-x)                            ; 各種設定ファイルを色付けする

;;=======================================================================
;; @ 折り返し表示 ON/OFF
;; ref. http://ubulog.blogspot.com/2007/09/emacsonoff.html
;;=======================================================================
(defun toggle-truncate-lines ()
  "折り返し表示をトグル動作します."
  (interactive)
  (if truncate-lines
      (setq truncate-lines nil)
    (setq truncate-lines t))
  (recenter))

(global-set-key "\C-c\C-l" 'toggle-truncate-lines) ; 折り返し表示ON/OFF