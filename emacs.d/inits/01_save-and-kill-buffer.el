;;=======================================================================
;; @ C-c C-c ： 現バッファの内容を保存してバッファを消す
;;   ref. http://howm.sourceforge.jp/cgi-bin/hiki/hiki.cgi?SaveAndKillBuffer
;;=======================================================================
(defun my-save-and-kill-buffer ()
  (interactive)
  (save-buffer)
  (kill-buffer nil))

(global-set-key "\C-c\C-c" 'my-save-and-kill-buffer)
