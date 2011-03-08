;;=======================================================================
;; @ 選択したurlからaタグを作成する
;;=======================================================================
(defun create-link-region ()
  "create link regionn"
  (interactive)
  (save-excursion
    (shell-command-on-region
     (point) (mark) "perl ~/.emacs.d/bin/create_link_region.pl" nil t)))