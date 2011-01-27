;=======================================================================
; load path
;=======================================================================
;(setq load-path
;      (append
;       (list (expand-file-name "~/.emacs/site-lisp")) load-path))

;=======================================================================
; load private-emacs.el
;=======================================================================
(load "~/rc/private/emacs.el" :if-does-not-exist nil)

;=======================================================================
; auto-install.el
;=======================================================================
(add-to-list 'load-path "~/.emacs/site-lisp/auto-install/")
(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/auto-install/")

;=======================================================================
; anything
;=======================================================================
(add-to-list 'load-path "~/.emacs/site-lisp/anything/")
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
(require 'ipa)
(require 'anything-ipa)

;=======================================================================
; color-theme
;=======================================================================
(add-to-list 'load-path "~/.emacs/site-lisp/color-theme/")

(when window-system
  (require 'color-theme)
  (color-theme-initialize)
;  (color-theme-dark-blue2)   ; Dark Blue2
  (color-theme-arjen)        ; Arjen
)

;=======================================================================
; font
;=======================================================================
(cond ((>= 23 emacs-major-version)            ; Enacs 23 以降
       (cond (window-system
              (cond ((eq system-type 'windows-nt)    ; NTEmacs
                     (set-default-font "M+2VM+IPAG circle-12")
                     (set-fontset-font (frame-parameter nil 'font)
                                       'japanese-jisx0208
                                       '("M+2VM+IPAG circle" . "unicode-bmp")
                                       ))
                    ((eq system-type 'darwin)         ; Mac
                     (create-fontset-from-ascii-font "Menlo-12:weight=normal:slant=normal" nil "menlokakugo")
                     (set-fontset-font "fontset-menlokakugo"
                                       'unicode
                                       (font-spec :family "Hiragino Kaku Gothic ProN" :size 14)
                                       nil
                                       'append)
                     (add-to-list 'default-frame-alist '(font . "fontset-menlokakugo"))
                     ))))))

;=======================================================================
; 初期フレーム（initial-frame）、新規フレーム（default-frame）の設定
;=======================================================================
(when window-system
  (setq initial-frame-alist
        (append
         '((width  . 125)   ; フレーム幅(文字数)
           (height . 42))   ; フレーム高(文字数)
         initial-frame-alist))
  (setq default-frame-alist
        (append
         '((width  . 125)   ; フレーム幅(文字数)
           (height . 42))   ; フレーム高(文字数)
         default-frame-alist))
)

;=======================================================================
; misc
;=======================================================================
(when window-system
    (mouse-wheel-mode t)                        ; ホイールマウス（あり）
    (set-scroll-bar-mode 'right)                ; スクロールバーを右に表示
    (tool-bar-mode 0)                           ; ツールバー表示なし
    (set-frame-parameter nil 'alpha 90)         ; フレームを透過
)
(menu-bar-mode nil)                             ; メニューバー表示なし
(global-font-lock-mode t)                       ; 文字の色つけ
(setq line-number-mode t)                       ; カーソルのある行番号を表示
(auto-compression-mode t)                       ; 日本語infoの文字化け防止
(setq make-backup-files nil)                    ; バックアップファイルを作らない
(setq auto-save-mode nil)                       ; 自動保存しない
(setq delete-auto-save-files t)                 ; 終了時にオートセーブファイルを消す
(load "dired-x")                                ; dired-x （C-x C-j）
(setq scroll-conservatively 1)                  ; 画面の下端にカーソルがある時に
                                                ; 一気にスクロールしないようにする
(setq frame-title-format                        ; フレームのタイトル指定
      (concat "%b - emacs@" system-name))
(setq inhibit-startup-message t)				; 起動時のメッセージを抑止する

;=======================================================================
; キー操作
;=======================================================================
(global-set-key   "\C-z"     'undo)                   ; undo
(global-set-key   "\C-h"     'backward-delete-char)   ; C-h でバックスペース
(global-set-key   "\C-c\C-e" 'eval-current-buffer)    ; .emacs再読込
(global-unset-key "\C-x\C-u")                         ; C-x C-u が何もしないように変更する
                                                      ;     （undo の typo 時誤動作防止）
(cond ((eq system-type 'darwin)         ; Mac
       (setq ns-command-modifier   (quote meta ))     ; commandキーとOptionキーを逆にする
       (setq ns-alternate-modifier (quote super))))
(define-key global-map (kbd "C-5") 'show-paren-mode)  ; 括弧の対応を見るモードを C-5 でトグルする。

;=======================================================================
; タブ
;=======================================================================
(setq-default indent-tabs-mode nil)             ; ソフトタブ
(setq-default tab-width 4)                      ; TAB幅=4
(setq tab-stop-list                             ; タブ幅の倍数を設定
 '(  4   8  12  16  20  24  28  32  36  40
    44  48  52  56  60  64  68  72  76  80
    84  88  92  96 100 104 108 112 116 120))

;=======================================================================
; 行番号表示
;=======================================================================
(add-to-list 'load-path "~/.emacs/site-lisp/linum/")
(require 'linum)
(global-linum-mode)

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

;=======================================================================
; Symbolic link ファイル編集時に yes/no を聞かないようにす
;=======================================================================
(custom-set-variables '(vc-follow-symlinks t))

;=======================================================================
; C-c C-c ： 現バッファの内容を保存してバッファを消す
;	ref. http://howm.sourceforge.jp/cgi-bin/hiki/hiki.cgi?SaveAndKillBuffer
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
(global-set-key "\C-c\et"  'my-get-time)

;=======================================================================
; clmemo.el
;=======================================================================
(add-to-list 'load-path "~/.emacs/site-lisp/clmemo/")
(autoload 'clmemo "clmemo" "ChangeLog memo mode." t)
(setq clmemo-file-name "~/rc/private/clmemo.txt")
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
(global-set-key "\C-c\C-w" 'weblogger-start-entry)

;=======================================================================
; タグジャンプ（etags M-. M-*）
;=======================================================================
(defadvice find-tag (before c-tag-file activate)
  "Automatically create tags file."
  (let ((tag-file (concat default-directory "TAGS")))
    (unless (file-exists-p tag-file)
      (shell-command "etags *.[ch] *.el .*.el -o TAGS 2>/dev/null"))
    (visit-tags-table tag-file)))

;=======================================================================
; 動的略語補完 dabbrev-ja
;=======================================================================
(add-to-list 'load-path "~/.emacs/site-lisp/dabbrev/")
(load "dabbrev-ja")
(global-set-key "\C-j" 'dabbrev-completion) ;;デフォルトはM-/

;=======================================================================
; ファイル名コーディング、ロケールコーディング
;=======================================================================
(cond
 ((or (eq window-system 'mac) (eq window-system 'ns))
  (require 'ucs-normalize)
  (setq file-name-coding-system 'utf-8-hfs)
  (setq locale-coding-system    'utf-8-hfs))
 ((or (eq system-type 'cygwin) (eq system-type 'windows-nt))
  (setq file-name-coding-system 'shift_jis)
  (setq locale-coding-system    'utf-8))
 (t
  (setq file-name-coding-system 'utf-8)
  (setq locale-coding-system    'utf-8))
)

;=======================================================================
; shell-pop
;=======================================================================
(add-to-list 'load-path "~/.emacs/site-lisp/shell-pop/")
(require 'shell-pop)
(global-set-key [f8]       'shell-pop)
(global-set-key "\C-c\C-o" 'shell-pop)
(global-set-key "\C-t"     'shell-pop)

(cond ((eq system-type 'windows-nt)     ; NTEmacs
       (shell-pop-set-internal-mode "eshell"))
      ((eq system-type 'darwin)         ; Mac
;       (shell-pop-set-internal-mode "ansi-term")
       (shell-pop-set-internal-mode "eshell")
      ))
(shell-pop-set-internal-mode-shell "/bin/zsh")
(shell-pop-set-window-height 60)

