;=======================================================================
; load path
;=======================================================================
;(setq load-path
;      (append
;       (list (expand-file-name "~/.emacs/site-lisp")) load-path))

;=======================================================================
; color-theme
;=======================================================================
(add-to-list 'load-path "~/.emacs/site-lisp/color-theme/")

(when window-system
  (require 'color-theme)
  (color-theme-initialize)
  ;(color-theme-aliceblue)   ; Alice Blue
  ;(color-theme-arjen)       ; Arjen
  (color-theme-ramangalahy) ; Ramangalahy
)

;=======================================================================
; misc
;=======================================================================
(mouse-wheel-mode 1)                            ; ホイールマウス
(menu-bar-mode 0)                               ; メニューバー表示有無
                                                ;     （0:表示しない、1:表示する）
(if window-system                               ; ツールバー表示有無
    (tool-bar-mode 0))                          ;     （0:表示しない、1:表示する）
(global-font-lock-mode t)                       ; 文字の色つけ
(setq line-number-mode t)                       ; カーソルのある行番号を表示
(auto-compression-mode t)                       ; 日本語infoの文字化け防止
(if window-system
    (set-scroll-bar-mode 'right))               ; スクロールバーを右に表示
(global-set-key "\C-z" 'undo)                   ; undo
(setq-default indent-tabs-mode nil)             ; ソフトタブ
(setq-default tab-width 4)                      ; TAB幅=4
(setq default-tab-width 4)                      ; TAB幅=4
(setq tab-stop-list                             ; タブ幅の倍数を設定
 '(  4   8  12  16  20  24  28  32  36  40
    44  48  52  56  60  64  68  72  76  80
    84  88  92  96 100 104 108 112 116 120))
(setq make-backup-files nil)                    ; バックアップファイルを作らない
(setq auto-save-mode nil)                       ; 自動保存しない
(setq delete-auto-save-files t)                 ; 終了時にオートセーブファイルを消す
(global-set-key "\C-h" 'backward-delete-char)   ; ctrl-hでバックスペース
(global-unset-key "\C-x\C-u")                   ; C-x C-u が何もしないように変更する
                                                ;     （undo の typo 時誤動作防止）
;(when
;  (boundp 'show-trailing-whitespace)
;  (setq-default show-trailing-whitespace t))    ; 行末のスペースを強調表示
(load "dired-x")                                ; dired-x （C-x C-j）
(setq scroll-conservatively 1)                  ; 画面の下端にカーソルがある時に一気にスクロールしないようにする
(setq frame-title-format					    ; フレームのタイトル指定
      (concat "%b - emacs@" system-name))

;=======================================================================
; クリップボードと共有する
;       ref. http://d.hatena.ne.jp/x68kace/20080317/p3
;=======================================================================
(global-unset-key "\C-y")
(global-set-key   "\C-y" 'clipboard-yank)
(global-unset-key "\C-w")
(global-set-key   "\C-w" 'clipboard-kill-region)
(global-unset-key "\M-w")
(global-set-key   "\M-w" 'clipboard-kill-ring-save)

;=======================================================================
; バッファリストの置き換え（bs）
;=======================================================================
(global-set-key [?\C-,]    'bs-cycle-next)
(global-set-key [?\C-.]    'bs-cycle-previous)
(global-set-key "\C-x\C-b" 'bs-show)

;=======================================================================
; Symbolic link ファイル編集時に yes/no を聞かないようにす
;=======================================================================
(custom-set-variables '(vc-follow-symlinks t))

;=======================================================================
; C-c C-c ： 現バッファの内容を保存してバッファを消す
;     ref. http://howm.sourceforge.jp/cgi-bin/hiki/hiki.cgi?SaveAndKillBuffer
;=======================================================================
(defun my-save-and-kill-buffer ()
  (interactive)
  (save-buffer)
  (kill-buffer nil))

(global-set-key "\C-c\C-c" 'my-save-and-kill-buffer)

;=======================================================================
; howm
;=======================================================================
(add-to-list 'load-path "~/.emacs/site-lisp/howm/")
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

;=======================================================================
; 日付入力 （M-x calendar）
;     ref. http://www.bookshelf.jp/soft/meadow_38.html#SEC563
;=======================================================================
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

;=======================================================================
; 日付簡易入力 （C-c C-d, C-c C-t, C-c Esc d）
;=======================================================================
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
(global-set-key "\C-c\et" 'my-get-time)

;=======================================================================
; clmemo.el
;=======================================================================
(add-to-list 'load-path "~/.emacs/site-lisp/clmemo/")
(autoload 'clmemo "clmemo" "ChangeLog memo mode." t)
(setq clmemo-file-name "~/clmemo.txt")
(global-set-key "\C-xM" 'clmemo)

;=======================================================================
; cua（M-x cua-mode）
;=======================================================================
(cua-mode t)
(setq cua-enable-cua-keys nil)

;=======================================================================
; wp-emacs
;=======================================================================
(add-to-list 'load-path "~/.emacs/site-lisp/wp-emacs/")
(require 'weblogger)
(load "~/rc/private/emacs.el" :if-does-not-exist nil)
(global-set-key "\C-c\C-w" 'weblogger-start-entry)
