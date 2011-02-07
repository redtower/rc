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
