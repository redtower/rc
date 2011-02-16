;;; imcap.el: capture images

;;; M-x imcap-capture
;;; M-x imcap-display

;;; var

(defvar imcap-capture-command-format "import %s")
(defvar imcap-paste-format ">>> %s")
(defvar imcap-file-name-format "%Y-%m-%d-%H%M%S.jpg")
(defvar imcap-directory nil) ;; nil means current directory
;; (defvar imcap-directory "~/imcap")

(defvar imcap-image-list nil)
(make-variable-buffer-local 'imcap-image-list)

;;; command

(defun imcap-capture ()
  (interactive)
  (let* ((filename (format-time-string imcap-file-name-format (current-time)))
         (fileloc (imcap-expand-file-name filename))
         (command (format imcap-capture-command-format fileloc))
         (command-name (car (split-string command)))
         (arguments (cdr (split-string command)))
         (paste (format imcap-paste-format
                        (if imcap-directory
                            (abbreviate-file-name fileloc)
                          filename))))
    (when (and (file-exists-p fileloc)
               (not (y-or-n-p (format "File %s exists. Overwrite? " fileloc))))
      (error "File can't write!"))
    (apply 'call-process command-name nil t nil arguments)
    ;;(shell-command command)
    (insert paste)
    (imcap-display)
    (message fileloc)))

(defun imcap-display ()
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (let ((buffer-read-only nil)
          (modified-p (buffer-modified-p)))
      (while (imcap-goto-next-image)
        (let* ((region (imcap-image-region))
               (filename (imcap-image-file))
               (fileloc (imcap-expand-file-name filename)))
          (when (file-exists-p fileloc)
            (let ((start (car region))
                  (end (cadr region))
                  (image (cons 'image (cdr (create-image fileloc nil nil :ascent 100)))))
              (add-text-properties start end
                                   (list 'display image
                                         'intangible image
                                         'rear-nonsticky (list 'display)))
              (setq imcap-image-list
                    (cons
                     (cons
                      fileloc
                      (image-size image t))
                     imcap-image-list))
              ))))
      (set-buffer-modified-p modified-p))))

;;; private

(defun imcap-expand-file-name (filename)
  ;;(abbreviate-file-name (expand-file-name filename imcap-directory)))
  (expand-file-name filename imcap-directory))

(defun imcap-goto-next-image ()
  (let ((regexp (format (regexp-quote imcap-paste-format)
                        "\\(.*\\.\\(jpg\\|png\\|gif\\)\\)")))
    (re-search-forward regexp nil t)))

(defun imcap-image-file ()
  (match-string-no-properties 1))

(defun imcap-image-region ()
  (list (match-beginning 0) (match-end 0)))

(defun imcap-image-resize (size)
  (save-excursion
    (let ((buffer-read-only nil)
          (modified-p (buffer-modified-p)))
      (when (imcap-goto-next-image)
        (let* ((region (imcap-image-region))
               (filename (imcap-image-file))
               (fileloc
                (imcap-expand-file-name filename))
               (image (get-text-property
                       (point) 'display))
               (image-width
                (car (cdr (assoc fileloc imcap-image-list))))
               (image-height
                (cdr (cdr (assoc fileloc imcap-image-list)))))
          (setq imcap-image-list
                (delete
                 (assoc fileloc imcap-image-list)
                 imcap-image-list))
          (setq imcap-image-list
                (cons
                 (cons
                  fileloc
                  (cons
                   (* size image-width)
                   (* size image-height)))
                 imcap-image-list))
          (when (file-exists-p fileloc)
            (let* ((start (car region))
                   (end (cadr region))
                   (thum
                    (with-temp-buffer
                      (set-buffer-multibyte nil)
                      (insert-file-contents filename)
                      (call-process-region
                       (point-min) (point-max)
                       "convert" t t nil
                       "-sample"
                       (int-to-string (* size image-width))
                       "-" "-")
                      (buffer-string)))
                   (image (create-image thum nil t))
                   )
              (add-text-properties
               start end
               (list 'display image
                     'intangible image
                     'rear-nonsticky (list 'display)))
              ))))
      (set-buffer-modified-p modified-p))))

(defun imcap-image-downsize ()
  (interactive)
  (beginning-of-line)
  (imcap-image-resize 0.9))

(defun imcap-image-upsize ()
  (interactive)
  (beginning-of-line)
  (imcap-image-resize 1.1))

;;;(define-key howm-mode-map [f11] 'imcap-image-downsize)
;;;(define-key howm-mode-map [f12] 'imcap-image-upsize)

;;; provide

(provide 'imcap)

