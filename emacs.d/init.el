;=======================================================================
; load path
;=======================================================================
;(setq load-path
;      (append
;       (list (expand-file-name "~/.emacs.d/elisp")) load-path))

;;=======================================================================
;; @ os check function
;;=======================================================================
(defun is_windows () (eq system-type 'windows-nt))      ; Windows
(defun is_mac     () (member window-system '(mac ns)))  ; Mac
(defun is_linux   () (eq window-system 'x))             ; Linux

;=======================================================================
; my-fav-modes
;=======================================================================
(defvar my-fav-modes
  '((emacs-lisp-mode 	. "\\.el$")
    (common-lisp-mode 	. "\\.\\(cl\\|lisp\\)$")
    (scheme-mode 		. "\\.scm$")
    (clojure-mode 		. "\\.clj$")
    (pir-mode 			. "\\.\\(imc\\|pir\\)$")
    (malabar-mode 		. "\\.java$")
    (php-mode 			. "\\.php[45]?$")
    (yaml-mode 			. "\\.ya?ml$")
    (js2-mode 			. "\\.js$")
    (ruby-mode 			. "\\.rb$")
    (text-mode 			. "\\.txt$")
    (fundamental-mode 	. nil)
    (LaTeX-mode 		. "\\.tex$")
    (org-mode 			. "\\.org$")
    (css-mode 			. "\\.css$")
    (nxml-mode 			. "\\.\\(xml\\|svg\\|wsdl\\|xslt\\|wsdd\\|xsl\\|rng\\|xhtml\\|jsp\\|tag\\)$")
    (howm-mode 			. "\\.howm$")
    (markdown-mode 		. "\\.\\(md\\|markdown\\)$")))

;=======================================================================
; path
;=======================================================================
;; より下に記述した物が PATH の先頭に追加されます
(dolist (dir (list
              "/sbin"
              "/usr/sbin"
              "/bin"
              "/usr/bin"
              "/usr/local/bin"
              (expand-file-name "~/bin")
              (expand-file-name "~/.emacs.d/elisp/darkroom-mode")
              (expand-file-name "~/rc/emacs.d/bin")
              ))
 ;; PATH と exec-path に同じ物を追加します
  (when (and (file-exists-p dir) (not (member dir exec-path)))
    (setenv "PATH" (concat dir ":" (getenv "PATH")))
    (setq exec-path (append (list dir) exec-path))))

;;=======================================================================
;; @ ime
;;=======================================================================
(cond
 ((is_windows)
  (setq default-input-method "W32-IME")         ; 標準IMEの設定
  (setq-default                                 ; IME状態のモードライン表示
   w32-ime-mode-line-state-indicator "[Aa]")
  (setq
   w32-ime-mode-line-state-indicator-list '("[Aa]" "[あ]" "[Aa]"))
  (w32-ime-initialize)                          ; IMEの初期化
  (setq w32-ime-buffer-switch-p nil))           ; バッファ切り替え時にIME状態を引き継ぐ
 ((is_mac)
  (setq default-input-method "japanese")))

(set-cursor-color "yellow")                     ; IME OFF時の初期カーソルカラー
(add-hook 'input-method-activate-hook           ; IME ON時のカーソルカラー
          (lambda() (set-cursor-color "green")))
(add-hook 'input-method-inactivate-hook         ; IME OFF時のカーソルカラー
          (lambda() (set-cursor-color "yellow")))

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

;;=======================================================================
;; @ font
;;=======================================================================
(cond
 ((>= 23 emacs-major-version) ; Enacs 23 以降
  (cond
   (window-system
    (cond
     ((eq system-type 'windows-nt)   ; NTEmacs
      (set-default-font "M+2VM+IPAG circle-12")
      (set-fontset-font
       (frame-parameter nil 'font)
       'japanese-jisx0208
       '("M+2VM+IPAG circle" . "unicode-bmp"))
      ; IME変換時フォントの設定（テストバージョンのみ）
      (setq w32-ime-font-face "MigMix 1M")
      (setq w32-ime-font-height 22))
     ((is_mac)                       ; Mac
      (create-fontset-from-ascii-font
       "Menlo-12:weight=normal:slant=normal" nil "menlokakugo")
      (set-fontset-font
       "fontset-menlokakugo"
       'unicode
       (font-spec :family "Hiragino Kaku Gothic ProN" :size 14)
       nil
       'append)
      (add-to-list 'default-frame-alist '(font . "fontset-menlokakugo"))
      ))))))

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
(setq frame-title-format                        ; フレームのタイトル指定
      (concat "%b - emacs@" system-name " - " system-configuration))

;;=======================================================================
;; @ misc
;;=======================================================================
(when window-system
    (mouse-wheel-mode t)                        ; ホイールマウス（あり）
    (set-scroll-bar-mode 'right)                ; スクロールバーを右に表示
    (tool-bar-mode 0)                           ; ツールバー表示なし
    (set-frame-parameter nil 'alpha 90)         ; フレームを透過
)
(if (is_mac) (menu-bar-mode 1)                  ; メニューバー表示あり
             (menu-bar-mode nil))               ; メニューバー表示なし
(global-font-lock-mode t)                       ; 文字の色つけ
(auto-compression-mode t)                       ; 日本語infoの文字化け防止
(setq make-backup-files nil)                    ; バックアップファイルを作らない
(setq delete-auto-save-files t)                 ; 終了時にオートセーブファイルを消す
(load "dired-x")                                ; dired-x （C-x C-j）
(fset 'yes-or-no-p 'y-or-n-p)                   ; "yes or no"を"y or n"に

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
;; @ default setting
;;=======================================================================
(setq inhibit-startup-message t)                ; 起動時のメッセージを抑止する
(setq inhibit-startup-echo-area-message -1)     ; スタートアップ時のエコー領域メッセージの非表示

;;=======================================================================
;; @ backup
;;=======================================================================
(setq make-backup-files nil)                    ; バックアップファイルを作らない
(setq auto-save-default nil)                    ; 自動保存しない
(setq auto-save-mode nil)                       ; 自動保存しない

;;=======================================================================
;; @ C-kで行が連結したときにインデントを減らす
;;=======================================================================
(defadvice kill-line (before kill-line-and-fixup activate)
  (when (and (not (bolp)) (eolp))
    (forward-char)
    (fixup-whitespace)
    (backward-char)))

;;=======================================================================
;; @ 全角空白、Tab、改行表示
;;=======================================================================
(add-to-list 'load-path "~/.emacs.d/elisp/jaspace/")
(require 'jaspace)
(setq jaspace-alternate-jaspace-string "□")
;(setq jaspace-alternate-eol-string "↓\n")
(setq jaspace-highlight-tabs t)
(setq jaspace-modes(mapcar 'car my-fav-modes))

;;=======================================================================
;; @ key bind
;;=======================================================================
(global-set-key   "\C-c\C-e" 'eval-current-buffer)    ; .emacs再読込
(global-unset-key "\C-x\C-u")                         ; C-x C-u が何もしないように変更する
                                                      ;     （undo の typo 時誤動作防止）
(define-key global-map (kbd "C-5") 'show-paren-mode)  ; 括弧の対応を見るモードを C-5 でトグルする。
(global-set-key "\C-z" 'undo)                         ; undo
(global-set-key "\M-s" 'query-replace-regexp)         ; 文字列置換
;(global-set-key "\C-m" 'reindent-then-newline-and-indent) ; 改行キーでオートインデント

;;=======================================================================
;; @ Command-Key and Option-Key Reverse
;;=======================================================================
(when (is_mac)
  (setq ns-command-modifier        'meta)
  (setq ns-alternate-modifier      'super)
  (setq mac-pass-command-to-system  nil))

;;=======================================================================
;; @ Move Cursor
;;=======================================================================
(global-set-key "\C-h"      'backward-delete-char)  ; C-h でバックスペース
;(global-set-key "\C-h"      'backward-char)        ; ←
;(global-set-key "\C-j"      'next-line)			; ↓
;(global-set-key "\C-k"      'previous-line)		; ↑
;(global-set-key "\C-l"      'forward-char)			; →
;(global-set-key "\C-n"      'newline-and-indent)   ; 改行してインデント
;(global-set-key "\C-o"      'kill-line)			; 行削除(C-kの代わり)
;(global-set-key (kbd "C-'") 'recenter)				; カーソル位置を画面中央に(C-lの代わり)

;;=======================================================================
;; @ カーソル位置の単語を削除(M-d)
;;=======================================================================
(defun kill-word-at-point ()
  (interactive)
  (let ((char (char-to-string (char-after (point)))))
    (cond
     ((string= " " char) (delete-horizontal-space))
     ((string-match "[\t\n -@\[-`{-~]" char) (kill-word 1))
     (t (forward-char) (backward-word) (kill-word 1)))))
(global-set-key "\M-d" 'kill-word-at-point)

;;=======================================================================
;; @ auto-install.el
;;=======================================================================
(add-to-list 'load-path "~/.emacs.d/elisp/auto-install/")
(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/auto-install/")

;;=======================================================================
;; @ anything
;;=======================================================================
(add-to-list 'load-path "~/.emacs.d/elisp/anything/")
(require 'anything-startup)
(global-set-key "\C-x\C-b" 'anything-for-files)

;=======================================================================
; ファイルにメモを残す（ips + anything-ipa）
;     M-x     ipa-insert   メモを作成
;     M-x     ipa-edit     カーソルより後のメモを編集
;     C-u M-x ipa-edit     カソルより前のメモを編集
;     M-x     ipa-move     メモを移動
;     M-x     anything-ipa anything で現在のバッファのメモをリスト。
;                          TAB でジャンプ。
;=======================================================================
;(require 'ipa)
;(require 'anything-ipa)

;;=======================================================================
;; @ fringe
;;=======================================================================
;(add-to-list 'load-path "~/.emacs.d/elisp/linum/")
;(require 'linum)
;(global-linum-mode t)                          ; バッファ中の行番号表示
;(set-face-attribute                            ; 行番号のフォーマット
; 'linum nil :foreground "red" :height 0.8)
;(setq linum-format "%4d")

;;=======================================================================
;; @ Darkroom-mode
;;=======================================================================
(add-to-list 'load-path "~/.emacs.d/elisp/darkroom-mode/")
(require 'darkroom-mode)
(defun toggle-darkroom ()
  (interactive)
;  (global-linum-mode nil)
  (darkroom-mode))
(global-set-key (kbd "C-c d") 'toggle-darkroom)

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

;;=======================================================================
;; @ コメントアウト
;;=======================================================================
(global-set-key "\C-x;" 'comment-region)              ; コメントアウト
(global-set-key "\C-x:" 'uncomment-region)            ; コメント解除

;;=======================================================================
;; @ タブ
;;=======================================================================
(setq-default indent-tabs-mode nil)             ; ソフトタブ
(setq-default tab-width 4)                      ; TAB幅=4
(setq tab-stop-list                             ; タブ幅の倍数を設定
 '(  4   8  12  16  20  24  28  32  36  40
    44  48  52  56  60  64  68  72  76  80
    84  88  92  96 100 104 108 112 116 120))

;;=======================================================================
;; @ クリップボードと共有する
;;   ref. http://d.hatena.ne.jp/x68kace/20080317/p3
;;=======================================================================
(global-unset-key "\C-y")
(global-set-key   "\C-y" 'clipboard-yank)
(global-unset-key "\C-w")
(global-set-key   "\C-w" 'clipboard-kill-region)
(global-unset-key "\M-w")
(global-set-key   "\M-w" 'clipboard-kill-ring-save)

;;=======================================================================
;; @ バッファリストの置き換え（bs）
;;=======================================================================
(global-set-key [?\C-,]    'bs-cycle-next)
(global-set-key [?\C-.]    'bs-cycle-previous)

;;=======================================================================
;; @ Symbolic link ファイル編集時に yes/no を聞かないようにする
;;=======================================================================
(custom-set-variables '(vc-follow-symlinks t))

;;=======================================================================
;; @ Window
;;=======================================================================
;; 分割したウィンドウ間を移動
(define-prefix-command 'windmove-map)
(global-set-key (kbd "C-o") 'windmove-map)
(define-key windmove-map "h" 'windmove-left)
(define-key windmove-map "j" 'windmove-down)
(define-key windmove-map "k" 'windmove-up)
(define-key windmove-map "l" 'windmove-right)
(define-key windmove-map "0" 'delete-window)
(define-key windmove-map "1" 'delete-other-windows)
(define-key windmove-map "2" 'split-window-vertically)
(define-key windmove-map "3" 'split-window-horizontally)

;; windowを分割・削除したときに幅をあわせる＋別のwindowに移動
;(defadvice-many (split-window-vertically
;                 split-window-horizontally
;                 delete-window) after
;  (balance-windows)
;  (other-window 1))
(defun split-window-conditional ()
  (interactive)
  (if (> (* (window-height) 2) (window-width))
      (split-window-vertically)
    (split-window-horizontally)))
(define-key windmove-map "s" 'split-window-conditional)
(define-key windmove-map "n"
  (lambda ()
    (interactive)
    (split-window-conditional)
    (switch-to-buffer "*scratch*")))

;;=======================================================================
;; @ C-c C-c ： 現バッファの内容を保存してバッファを消す
;;   ref. http://howm.sourceforge.jp/cgi-bin/hiki/hiki.cgi?SaveAndKillBuffer
;;=======================================================================
(defun my-save-and-kill-buffer ()
  (interactive)
  (save-buffer)
  (kill-buffer nil))

(global-set-key "\C-c\C-c" 'my-save-and-kill-buffer)

;;=======================================================================
;; @ howm
;;=======================================================================
(add-to-list 'load-path "~/.emacs.d/elisp/howm/")
(setq howm-menu-lang 'ja)
(global-set-key "\C-c,," 'howm-menu)

(mapc
 (lambda (f)
   (autoload f
     "howm" "Hitori Otegaru Wiki Modoki" t))
 '(howm-menu howm-list-all howm-list-recent
             howm-list-grep howm-create
             howm-keyword-to-kill-ring))
(eval-after-load "howm-mode"                    ; リンクを TAB で辿る
  '(progn
     (define-key howm-mode-map [tab] 'action-lock-goto-next-link)
     (define-key howm-mode-map [(meta tab)] 'action-lock-goto-previous-link)))

(setq howm-list-recent-title t)                 ; 「最近のメモ」一覧時にタイトル表示
(setq howm-list-all-title t)                    ; 全メモ一覧時にタイトル表示
(setq howm-menu-expiry-hours 2)                 ; メニューを 2 時間キャッシュ
(add-hook 'howm-mode-on-hook 'auto-fill-mode)   ; howm の時は auto-fill で
(setq howm-view-summary-persistent nil)         ; RET でファイルを開く際, 一覧バッファを消す
                                                ; C-u RET なら残る
(setq howm-menu-schedule-days 7)                ; メニューの予定表の表示範囲（7 日前から）
(setq howm-menu-schedule-days-before 3)         ; メニューの予定表の表示範囲（3 日後まで）
(setq howm-file-name-format                     ; howm のファイル名（1 メモ 1 ファイル）
      "%Y/%m/%Y-%m-%d-%H%M%S.howm")
(setq howm-view-grep-parse-line
      "^\\(\\([a-zA-Z]:/\\)?[^:]*\\.howm\\):\\([0-9]*\\):\\(.*\\)$")
(setq howm-excluded-file-regexp                 ; 検索しないファイルの正規表現
      "/\\.#\\|[~#]$\\|\\.bak$\\|/CVS/\\|\\.doc$\\|\\.pdf$\\|\\.ppt$\\|\\.xls$")
; いちいち消すのも面倒なので内容が 0 ならファイルごと削除する
(if (not (memq 'delete-file-if-no-contents after-save-hook))
    (setq after-save-hook
          (cons 'delete-file-if-no-contents after-save-hook)))
(defun delete-file-if-no-contents ()
  (when (and
         (buffer-file-name (current-buffer))
         (string-match "\\.howm" (buffer-file-name (current-buffer)))
         (= (point-min) (point-max)))
    (delete-file
     (buffer-file-name (current-buffer)))))

;;=======================================================================
;; @ 日付入力 （M-x calendar）
;;     ref. http://www.bookshelf.jp/soft/meadow_38.html#SEC563
;;=======================================================================
(eval-after-load "calendar"
  '(progn
     (define-key calendar-mode-map
       "\C-m" 'my-insert-day)
     (defun my-insert-day ()
       (interactive)
       (let ((day nil)
             (calendar-date-display-form
         '("[" year "-" (format "%02d" (string-to-int month))
           "-" (format "%02d" (string-to-int day)) "]")))
         (setq day (calendar-date-string
                    (calendar-cursor-to-date t)))
         (exit-calendar)
         (insert day)))))

;;=======================================================================
;; @ 日付簡易入力 （C-c C-d, C-c C-t, C-c Esc d）
;;=======================================================================
(defun my-get-date-gen (form)
  (insert (format-time-string form)))
(defun my-get-date ()
  (interactive)
  (my-get-date-gen "[%Y-%m-%d]"))
(defun my-get-time ()
  (interactive)
  (my-get-date-gen "[%H:%M]"))
(defun my-get-dtime ()
  (interactive)
  (my-get-date-gen "[%Y-%m-%d %H:%M]"))
(global-set-key "\C-c\C-d" 'calendar)
(global-set-key "\C-c\C-t" 'my-get-dtime)
(global-set-key "\C-c\et"  'my-get-time)

;;=======================================================================
;; @ clmemo.el
;;=======================================================================
(add-to-list 'load-path "~/.emacs.d/elisp/clmemo/")
(autoload 'clmemo "clmemo" "ChangeLog memo mode." t)
(setq clmemo-file-name "~/rc/private/clmemo.txt")
(global-set-key "\C-xM" 'clmemo)

;;=======================================================================
;; @ cua（M-x cua-mode）
;;=======================================================================
(cua-mode t)
(setq cua-enable-cua-keys nil)

;;=======================================================================
;; @ wp-emacs
;;=======================================================================
(add-to-list 'load-path "~/.emacs.d/elisp/wp-emacs/")
(require 'weblogger)
(global-set-key "\C-c\C-w" 'weblogger-start-entry)

;;=======================================================================
;; @ タグジャンプ（etags M-. M-*）
;;=======================================================================
(defadvice find-tag (before c-tag-file activate)
  "Automatically create tags file."
  (let ((tag-file (concat default-directory "TAGS")))
    (unless (file-exists-p tag-file)
      (shell-command "etags *.[ch] *.cs *.el .*.el -o TAGS 2>/dev/null"))
    (visit-tags-table tag-file)))

;;=======================================================================
;; @ GNU GLOBAL（gtags）
;;=======================================================================
(add-to-list 'load-path "~/.emacs.d/elisp/gtags/")
(autoload 'gtags-mode "gtags" "" t)
(setq gtags-mode-hook
      '(lambda ()
         (local-set-key "\M-t" 'gtags-find-tag)
         (local-set-key "\M-r" 'gtags-find-rtag)
         (local-set-key "\M-s" 'gtags-find-symbol)
         (local-set-key "\C-t" 'gtags-pop-stack)
         ))

;;=======================================================================
;; @ ファイル名コーディング、ロケールコーディング
;;=======================================================================
(cond
 ((is_mac)
  (require 'ucs-normalize)
  (setq file-name-coding-system 'utf-8-hfs)
  (setq locale-coding-system    'utf-8-hfs))
 ((is_windows)
  (setq file-name-coding-system 'shift_jis)
  (setq locale-coding-system    'utf-8))
 (t
  (setq file-name-coding-system 'utf-8)
  (setq locale-coding-system    'utf-8))
)

;;=======================================================================
;; @ shell-pop
;;=======================================================================
(add-to-list 'load-path "~/.emacs.d/elisp/shell-pop/")
(require 'shell-pop)
(global-set-key [f8]       'shell-pop)
(global-set-key "\C-c\C-o" 'shell-pop)
(global-set-key "\C-t"     'shell-pop)

(cond ((is_windows)     ; NTEmacs
       (shell-pop-set-internal-mode "eshell")
       (shell-pop-set-internal-mode-shell "bash"))
      ((is_mac)         ; Mac
       (shell-pop-set-internal-mode "ansi-term")
;       (shell-pop-set-internal-mode "eshell")
       (shell-pop-set-internal-mode-shell "/bin/zsh"))
      )

(shell-pop-set-window-height 60)

;;=======================================================================
;; @ markdown-mode
;;=======================================================================
(add-to-list 'load-path "~/.emacs.d/elisp/markdown-mode/")
(autoload 'markdown-mode "markdown-mode.el"
   "Major mode for editing Markdown files" t)
(setq auto-mode-alist
   (cons '("\\.\\(md\\|markdown\\)" . markdown-mode) auto-mode-alist))

;;=======================================================================
;; @ 動的略語補完 dabbrev-ja
;;=======================================================================
(add-to-list 'load-path "~/.emacs.d/elisp/dabbrev/")
(load "dabbrev-ja")
(global-set-key "\C-j" 'dabbrev-completion) ; デフォルトはM-/
(setq dabbrev-case-fold-search nil)         ; 大文字小文字を区別

;;=======================================================================
;; @ auto-complete（補完候補を自動ポップアップ）
;;=======================================================================
(add-to-list 'load-path "~/.emacs.d/elisp/auto-complete/")
(require 'auto-complete)
(global-auto-complete-mode t)
;(setq ac-modes (cons 'js-mode ac-modes))
(setq ac-modes (mapcar 'car my-fav-modes))

;;=======================================================================
;; @ 関連付けから外部プログラムを起動する
;;     ref. http://k4zmblog.dtiblog.com/blog-entry-153.html
;;     ref. http://d.hatena.ne.jp/sr10/20110118/1295280250
;;=======================================================================
(defun uenox-dired-winstart ()
  "Type '[uenox-dired-winstart]': win-start the current line's file."
  (interactive)
  (if (eq major-mode 'dired-mode)
      (let ((fname (dired-get-filename)))
        (w32-shell-execute "open" fname)
        (message "win-started %s" fname))))
;;; dired のキー割り当て追加
(add-hook 'dired-mode-hook
          (lambda ()
            (define-key dired-mode-map "z" 'uenox-dired-winstart))) ;; キーバインド 

;;=======================================================================
;; @ zencoding-mode
;;=======================================================================
(add-to-list 'load-path "~/.emacs.d/elisp/zencoding-mode/")
(require 'zencoding-mode) 
(add-hook 'sgml-mode-hook 'zencoding-mode) ; html-modeとかで自動出来にzencodingできるようにする
(define-key zencoding-mode-keymap    (kbd "C-c C-n") 'zencoding-expand-line)
(define-key zencoding-preview-keymap (kbd "C-c C-n") 'zencoding-preview-accept)

;;=======================================================================
;; @ bf-mode - dired でファイルの内容を表示する
;;=======================================================================
(add-to-list 'load-path "~/.emacs.d/elisp/bf-mode/")
(require 'bf-mode)
(setq bf-mode-browsing-size 10000)                  ; 別ウィンドウに表示するサイズの上限
(setq bf-mode-except-ext '("\\.exe$" "\\.com$"))    ; 別ウィンドウに表示しないファイルの拡張子
(setq bf-mode-force-browse-exts                     ; 容量がいくつであっても表示して欲しいもの
      (append '("\\.texi$" "\\.el$")
              bf-mode-force-browse-exts))
(setq bf-mode-html-with-w3m t)                      ; html は w3m で表示する
(setq bf-mode-archive-list-verbose t)               ; 圧縮されたファイルを表示
(setq bf-mode-directory-list-verbose t)             ; ディレクトリ内のファイル一覧を表示

;;=======================================================================
;; @ Tumble
;;=======================================================================
(add-to-list 'load-path "~/.emacs.d/elisp/tumble/")
(require 'tumble)

;;=======================================================================
;; @ color-moccur
;;=======================================================================
(add-to-list 'load-path "~/.emacs.d/elisp/color-moccur/")
(require 'color-moccur)

;;=======================================================================
;; @ moccur-edit
;;=======================================================================
(add-to-list 'load-path "~/.emacs.d/elisp/moccur-edit/")
(require 'moccur-edit)

;;=======================================================================
;; @ yasnippet
;;=======================================================================
(add-to-list 'load-path "~/.emacs.d/elisp/yasnippet/")
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/elisp/yasnippet/snippets")

;;=======================================================================
;; @ navi2ch
;;=======================================================================
(add-to-list 'load-path "~/.emacs.d/elisp/navi2ch/share/emacs/site-lisp/")
(autoload 'navi2ch "navi2ch" "Navigator for 2ch for Emacs" t)
(setq navi2ch-article-auto-range nil)               ; 最初に全件表示する(デフォルトは100)

;;=======================================================================
;; @ emacs-w3m
;;=======================================================================
(add-to-list 'load-path "~/.emacs.d/elisp/emacs-w3m/share/emacs/site-lisp/w3m/")
(require 'w3m-load)
(defun browse-url-default-macosx-browser (url &optional new-window)
  (interactive (browse-url-interactive-arg "URL: "))
  (if (and new-window (>= emacs-major-version 23))
      (ns-do-applescript
       (format (concat "tell application \"Safari\" to make document with properties {URL:\"%s\"}\n"
		       "tell application \"Safari\" to activate") url))
    (start-process (concat "open " url) nil "open" url)))

(defun choose-browser (url &rest args)
  (interactive "sURL: ")
  (if (y-or-n-p "Use external browser? ")
      (browse-url-default-macosx-browser url)
      (w3m-browse-url url)))
(setq browse-url-browser-function 'choose-browser)
(global-set-key "\C-xm" 'browse-url-at-point)       ; カーソル位置の文字列をURLとしてブラザを起動する

;;=======================================================================
;; @ japanese-holidays.el
;;=======================================================================
(add-to-list 'load-path "~/.emacs.d/elisp/japanese-holidays")
(add-hook 'calendar-load-hook
          (lambda ()
            (require 'japanese-holidays)
            (setq calendar-holidays
                  (append japanese-holidays local-holidays other-holidays))))

;;=======================================================================
;; @ calfw.el
;;   ref. http://d.hatena.ne.jp/kiwanami/?20110107215552
;;=======================================================================
(add-to-list 'load-path "~/.emacs.d/elisp/calfw")
(require 'calfw)
(global-set-key "\C-cl"  'cfw:open-calendar-buffer)
(defvar my-howm-schedule-page "2011年予定") ; 予定を入れるメモのタイトル
(defun my-cfw-open-schedule-buffer ()
  (interactive)
  (let* 
      ((date (cfw:cursor-to-nearest-date))
       (howm-items 
        (howm-folder-grep
         howm-directory
         (regexp-quote my-howm-schedule-page))))
    (cond
     ((null howm-items) ; create
      (howm-create-file-with-title my-howm-schedule-page nil nil nil nil))
     (t
      (howm-view-open-item (car howm-items))))
    (goto-char (point-max))
    (unless (bolp) (insert "\n"))
    (insert
     (format "[%04d-%02d-%02d]@ "
             (calendar-extract-year date)
             (calendar-extract-month date)
             (calendar-extract-day date)))))
;;=======================================================================
;; @ カレンダー表記
;;=======================================================================
(setq calendar-month-name-array    ;; 月
      ["January" "February" "March"     "April"   "May"      "June"
       "July"    "August"   "September" "October" "November" "December"])
(setq calendar-day-name-array      ;; 曜日
      ["Sun" "Mon" "Tue" "Wed" "Thu" "Fri" "Sat"])

;;=======================================================================
;; @ calfw <-> howm 連携
;;=======================================================================
(eval-after-load "howm-menu"         ; calfw <-> howm 連携
  '(progn
     (require 'calfw-howm)
     (cfw:install-howm-schedules)
     (define-key howm-mode-map (kbd "M-C") 'cfw:elscreen-open-howm-calendar)
     (define-key cfw:howm-schedule-map (kbd "i") 'my-cfw-open-schedule-buffer)
     (define-key cfw:howm-schedule-inline-keymap (kbd "i") 'my-cfw-open-schedule-buffer)
     ))

(setq cfw:howm-schedule-summary-transformer 
  (lambda (line) (split-string (replace-regexp-in-string "^[^@!]+[@!] " "" line) " / ")))

;;=======================================================================
;; @ calfw <-> ical（Google Calendar） 連携
;;   Google Calendar の iCalの指定は、~/rc/private/emacs.el
;;=======================================================================
;(require 'calfw-ical)
;(cfw:install-ical-schedules)
;;(setq cfw:ical-calendar-contents-sources '("http://www.google.com/calendar/ical/～.ics"))

;=======================================================================
; load private-emacs.el
;=======================================================================
(load "~/rc/private/emacs.el" :if-does-not-exist nil)

;;=======================================================================
;; @ ホームディレクトリに移動する
;;=======================================================================
(cd "~")

