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
