;;=======================================================================
;; @ Vimpulse
;;=======================================================================
(setq viper-mode t)
(require 'vimpulse)

(define-key global-map [M-delete] 'toggle-viper-mode)       ; Vimpulse起動／終了

;;=======================================================================
;; @ キーバインド
;;=======================================================================
(vimpulse-map "\C-u" 'viper-scroll-screen-back)             ; C-u：逆スクロール
(vimpulse-map "\C-r" 'anything-recentf)                     ; C-r：anything-recentf

;;=======================================================================
;; @ misc
;;=======================================================================
(setq viper-shift-width tab-width)      ; インデント幅を設定

;;=======================================================================
;; @ viper-modeの起動／終了時の設定変更
;;=======================================================================
;; 起動時に設定変更
(defadvice viper-mode (after my-viper-mode activate)
  (linum-mode t))                       ; 行番号を表示(linum-mode on)

;; 終了時に設定を戻す
(setq my-viper-default-face-background  ; モードラインの色設定を保存
      (face-background 'mode-line))
(defadvice viper-go-away (after my-viper-go-away activate)
  (linum-mode nil)                      ; 行番号を非表示(linum-mode off))
  (set-face-background                  ; モードラインの色設定を復元
   'mode-line my-viper-default-face-background)
  (message  "exit viper-mode"))

;;=======================================================================
;; @ モードラインの色変更
;;=======================================================================
(defun my-viper-set-mode-line-face ()
  (unless (minibufferp (current-buffer))
    (set-face-background 'mode-line
                         (cdr (assq viper-current-state
                                    '((vi-state       . "Darkred")
                                      (insert-state   . "Black")
                                      (emacs-state    . "Wheat")
                                      (operator-state . "Green")
                                      (visual-state   . "Blue")
                                      ))))))
(dolist (hook (list
  'viper-vi-state-hook
  'viper-insert-state-hook
  'viper-emacs-state-hook
  'vimpulse-operator-state-hook
  'vimpulse-visual-state-hook
  ))(add-hook hook 'my-viper-set-mode-line-face))

;;=======================================================================
;; @ viper-mode off
;;=======================================================================
;;(viper-mode)
(viper-go-away)
