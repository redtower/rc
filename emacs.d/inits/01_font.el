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
