;;=======================================================================
;; @ japanese-holidays.el
;;=======================================================================
(add-hook 'calendar-load-hook
          (lambda ()
            (require 'japanese-holidays)
            (setq calendar-holidays
                  (append japanese-holidays local-holidays other-holidays))))

;;=======================================================================
;; @ calendar
;;   ref. http://www.heimat.gr.jp/pipermail/elips/2000/000238.html
;;=======================================================================
; 祝祭日に印を付ける。
(setq mark-holidays-in-calendar t)
; 現在日付に印をつける。
(add-hook 'today-visible-calendar-hook   'calendar-mark-today)

;; 週末（weekend）に色を付ける。
(setq calendar-weekend-marker 'diary)
(add-hook 'today-visible-calendar-hook   'calendar-mark-weekend)
(add-hook 'today-invisible-calendar-hook 'calendar-mark-weekend)
; 週末を土日に設定する。
(setq calendar-weekend '(0 6))

;; 日曜日のフェイスを設定
(make-face 'sunday-face)
(set-face-foreground 'sunday-face "Tomato")
;; 土曜日のフェイスを設定
(make-face 'saturday-face)
(set-face-foreground 'saturday-face "LightBlue")
(setq calendar-sunday-marker   'sunday-face)
(setq calendar-saturday-marker 'saturday-face)
(setq diary-entry-marker (quote bold-italic))

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
