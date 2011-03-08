;;=======================================================================
;; @ calfw.el
;;   ref. http://d.hatena.ne.jp/kiwanami/?20110107215552
;;=======================================================================
(require 'calfw)
(global-set-key "\C-cl"  'cfw:open-calendar-buffer)
(defvar my-howm-schedule-page "2011年予定") ; 予定を入れるメモのタイトル
(defun my-cfw-open-schedule-buffer ()
  (interactive)
  (let* 
      ((date (cfw:cursor-to-nearest-date))
       (howm-items 
        (howm-folder-grep
         howm-directory
         (regexp-quote my-howm-schedule-page))))
    (cond
     ((null howm-items) ; create
      (howm-create-file-with-title my-howm-schedule-page nil nil nil nil))
     (t
      (howm-view-open-item (car howm-items))))
    (goto-char (point-max))
    (unless (bolp) (insert "\n"))
    (insert
     (format "[%04d-%02d-%02d]@ "
             (calendar-extract-year date)
             (calendar-extract-month date)
             (calendar-extract-day date)))))
;;=======================================================================
;; @ カレンダー表記
;;=======================================================================
(setq calendar-month-name-array    ;; 月
      ["January" "February" "March"     "April"   "May"      "June"
       "July"    "August"   "September" "October" "November" "December"])
(setq calendar-day-name-array      ;; 曜日
      ["Sun" "Mon" "Tue" "Wed" "Thu" "Fri" "Sat"])

;;=======================================================================
;; @ calfw <-> howm 連携
;;=======================================================================
(eval-after-load "howm-menu"         ; calfw <-> howm 連携
  '(progn
     (require 'calfw-howm)
     (cfw:install-howm-schedules)
     (define-key howm-mode-map (kbd "M-C") 'cfw:elscreen-open-howm-calendar)
     (define-key cfw:howm-schedule-map (kbd "i") 'my-cfw-open-schedule-buffer)
     (define-key cfw:howm-schedule-inline-keymap (kbd "i") 'my-cfw-open-schedule-buffer)
     ))

(setq cfw:howm-schedule-summary-transformer 
  (lambda (line) (split-string (replace-regexp-in-string "^[^@!]+[@!] " "" line) " / ")))

;;=======================================================================
;; @ calfw <-> ical（Google Calendar） 連携
;;   Google Calendar の iCalの指定は、~/rc/private/emacs.el
;;=======================================================================
;(require 'calfw-ical)
;(cfw:install-ical-schedules)
;;(setq cfw:ical-calendar-contents-sources '("http://www.google.com/calendar/ical/～.ics"))
