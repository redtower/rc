(when window-system
;; default color
(add-to-list 'default-frame-alist '(cursor-color . "SlateBlue2"))
(add-to-list 'default-frame-alist '(mouse-color . "SlateBlue2"))
(add-to-list 'default-frame-alist '(foreground-color . "gray10"))
(add-to-list 'default-frame-alist '(background-color . "white"))
(set-face-foreground 'modeline "white")
(set-face-background 'modeline "SlateBlue2")
(set-face-background 'region  "LightSteelBlue1")

;; faces
(set-face-foreground 'font-lock-comment-face "MediumSeaGreen")
(set-face-foreground 'font-lock-string-face  "purple")
(set-face-foreground 'font-lock-keyword-face "blue")
(set-face-foreground 'font-lock-function-name-face "blue")
(set-face-bold-p 'font-lock-function-name-face t)
(set-face-foreground 'font-lock-variable-name-face "black")
(set-face-foreground 'font-lock-type-face "LightSeaGreen")
(set-face-foreground 'font-lock-builtin-face "purple")
(set-face-foreground 'font-lock-constant-face "black")
(set-face-foreground 'font-lock-warning-face "blue")
(set-face-bold-p 'font-lock-warning-face nil)
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
(setq-default tab-width 4)                      ; TAB幅=4
(setq-default indent-tabs-mode nil)             ; ソフトタブ
(setq tab-stop-list                             ; タブ幅の倍数を設定
 '(  4   8  12  16  20  24  28  32  36  40
    44  48  52  56  60  64  68  72  76  80
    84  88  92  96 100 104 108 112 116 120))
(setq make-backup-files nil)                    ; バックアップファイルを作らない
(setq delete-auto-save-files t)                 ; 終了時にオートセーブファイルを消す
(global-set-key "\C-h" 'backward-delete-char)   ; ctrl-hでバックスペース
(global-unset-key "\C-x\C-u")                   ; C-x C-u が何もしないように変更する
                                                ;     （undo の typo 時誤動作防止）
(when
 (boundp 'show-trailing-whitespace)
 (setq-default show-trailing-whitespace t))     ; 行末のスペースを強調表示

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

