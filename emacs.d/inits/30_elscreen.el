;;=======================================================================
;; @ ElScreen
;;   EmacsでGNU screen風のインターフェイスを使う
;;   ref. http://www.morishima.net/~naoto/software/elscreen/index.php.ja
;;=======================================================================
(setq elscreen-prefix-key "\C-t")
(require 'elscreen)

;;=======================================================================
;; @ screen toggle を C-t C-t にする。
;;=======================================================================
(define-key elscreen-map "\C-t" 'elscreen-toggle)

;;=======================================================================
;; @ ElScreenでスクリーンが1つの時に自動でスクリーンを生成する
;;=======================================================================
(defmacro elscreen-create-automatically (ad-do-it)
  `(if (not (elscreen-one-screen-p))
       ,ad-do-it
     (elscreen-create)
     (elscreen-notify-screen-modification 'force-immediately)
     (elscreen-message "New screen is automatically created")))

(defadvice elscreen-next (around elscreen-create-automatically activate)
  (elscreen-create-automatically ad-do-it))

(defadvice elscreen-previous (around elscreen-create-automatically activate)
  (elscreen-create-automatically ad-do-it))

(defadvice elscreen-toggle (around elscreen-create-automatically activate)
  (elscreen-create-automatically ad-do-it))

;;=======================================================================
;; @ frame-titleにスクリーンの一覧を表示する
;;=======================================================================
(defun elscreen-frame-title-update ()
  (when (elscreen-screen-modified-p 'elscreen-frame-title-update)
    (let* ((screen-list (sort (elscreen-get-screen-list) '<))
           (screen-to-name-alist (elscreen-get-screen-to-name-alist))
           (title (mapconcat
                   (lambda (screen)
                     (format "%d%s %s"
                             screen (elscreen-status-label screen)
                             (cond
                              ((is_mac)
                               (get-alist screen screen-to-name-alist))
                              ((is_windows)
                               (encode-coding-string
                                (get-alist screen screen-to-name-alist)
                                'sjis-dos)))))
                   screen-list " ")))
      (if (fboundp 'set-frame-name)
          (set-frame-name title)
        (setq frame-title-format title)))))

(eval-after-load "elscreen"
  '(add-hook 'elscreen-screen-update-hook 'elscreen-frame-title-update))

;;=======================================================================
;; @ elscreenのタブを表示しない。
;;=======================================================================
(setq elscreen-display-tab nil)

;;=======================================================================
;; @ ElScreen-dired
;;=======================================================================
(require 'elscreen-dired)
