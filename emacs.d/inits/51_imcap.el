;;=======================================================================
;; @ imcap.el
;;   ref. http://www.bookshelf.jp/soft/meadow_38.html#SEC565
;;=======================================================================
(setq
 howm-excluded-file-regexp
 (concat
  "\\(^\\|/\\)\\([.]\\|CVS/\\)\\|"
  "[~#]$\\|"
  "\\.\\("
  (mapconcat
   (lambda (f) f)
   '(
     "doc" "pdf" "ppt" "xls"
     "bak" "elc" "gz" "aux"
     "toc" "idx" "dvi" "jpg"
     "gif" "png"
     ) "\\|") "\\)$"))

(cond ((is_windows)
       (setq imcap-capture-command-format
             (concat
              "~/.emacs.d/bin/winshot/WinShot.exe"
              " -Jpeg -Rectangle -Close -File %s"))))

(autoload 'imcap-capture "imcap"
  "Hitori Otegaru Wiki Modoki image capture" t)
(autoload 'imcap-display "imcap"
  "Hitori Otegaru Wiki Modoki image capture" t)
(add-hook 'howm-view-open-hook 'imcap-display)

;;=======================================================================
;; メモ削除時に画像ファイルの削除を確認する。
;;=======================================================================
(defadvice kill-region
  (around delete-image-file activate)
  (when (and (boundp 'howm-mode)
             howm-mode)
    (let ((str
           (split-string
            (buffer-substring-no-properties
             (ad-get-arg 0)
             (ad-get-arg 1)) "[\n\r]+"))
          (line nil)
          (imagefile nil))
      (while str
        (setq line (car str))
        (if (string-match
             ">>> \\(.*\\.\\(jpg\\|png\\|gif\\)\\)"
             line)
            (setq imagefile (match-string 1 line)))
        (when (and imagefile
                   (file-exists-p
                    (expand-file-name imagefile)))
          (if (y-or-n-p
               (format
                "Delete image file %s?" imagefile))
              (progn
                (setq imagefile
                      (expand-file-name imagefile))
                (delete-file imagefile))))
        (setq imagefile nil)
        (setq str (cdr str)))))
  ad-do-it)

;;=======================================================================
;; ドラッグ＆ドロップで貼り付け
;;=======================================================================
(when (is_windows)
  (defun howm-w32-dnd-ref-file (event)
    "Add ref to drop files."
    (interactive "e")
    (mapc
     #'(lambda (file)
         (insert (format howm-template-file-format file) "\n"))
     (car (cdr (cdr event)))))
  (eval-after-load "howm-mode"
    '(progn
       (define-key howm-mode-map [S-drag-n-drop] 'howm-w32-dnd-ref-file))))

;;=======================================================================
;; 画像ファイルを拡大（f12）・縮小（f11）
;;=======================================================================
(autoload 'imcap-image-downsize "imcap" "imcap" t)
(autoload 'imcap-image-upsize   "imcap" "imcap" t)

(eval-after-load "howm-mode"
  '(progn
     (define-key howm-mode-map [f11] 'imcap-image-downsize)
     (define-key howm-mode-map [f12] 'imcap-image-upsize)))
