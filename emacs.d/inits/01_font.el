;;=======================================================================
;; @ font
;;=======================================================================
(cond
 ((>= emacs-major-version 23) ; Enacs 23 以降
  (cond
   (window-system
    (cond
     ((eq system-type 'windows-nt)   ; NTEmacs
      (set-default-font "M+2VM+IPAG circle-12")
      (set-fontset-font (frame-parameter nil 'font)
                        'japanese-jisx0208
                        '("M+2VM+IPAG circle" . "unicode-bmp"))
      ; IME変換時フォントの設定（テストバージョンのみ）
      (setq w32-ime-font-face "MigMix 1M")
      (setq w32-ime-font-height 22))
     ((is_mac)                       ; Mac
      (set-default-font "Monaco-14")
      (set-fontset-font (frame-parameter nil 'font)
                        'japanese-jisx0208
                        '("ヒラギノ角ゴ pro w3" . "jisx0208.1983")))
     (
      (set-default-font "Monospace-12")
      (set-fontset-font (frame-parameter nil 'font)
                        'japanese-jisx0208
                        '("IPAゴシック" . "unicode-bmp")))
     )))))
