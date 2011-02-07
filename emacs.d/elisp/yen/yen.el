;;; yen.el -- show sum of "xxx yen" in region
;;; Copyright (c) 2003 by HIRAOKA Kazuyuki <hira@me.ics.saitama-u.ac.jp>
;;; $Id: yen.el,v 1.2 2003/10/28 15:46:01 hira Exp hira $
;;;
;;; This program is free software; you can redistribute it and/or modify
;;; it under the terms of the GNU General Public License as published by
;;; the Free Software Foundation; either version 1, or (at your option)
;;; any later version.
;;;
;;; This program is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; The GNU General Public License is available by anonymouse ftp from
;;; prep.ai.mit.edu in pub/gnu/COPYING.  Alternately, you can write to
;;; the Free Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139,
;;; USA.
;;--------------------------------------------------------------------

;;; M-x yen-region で, 領域中の「○○円」を合計.
;;; ・結果は minibuffer に表示
;;; ・C-y で結果を paste できる
;;; ・「31,415 円」のような表記にも対応

(defvar yen-regexp "\\(-?[0-9.,]+\\) ?円")
(defvar yen-number-pos 1)
(defvar yen-ignore-char ?,)

(defun yen-region (beg end)
  (interactive "r")
  (save-excursion
    (goto-char beg)
    (let ((sum 0))
      (while (yen-search end)
        (setq sum (+ sum (yen-number))))
      (let ((ans (number-to-string sum)))
        (kill-new ans)
        (message ans)))))
      
(defun yen-search (end)
  (re-search-forward yen-regexp end t))

(defun yen-number ()
  (let* ((orig (match-string-no-properties yen-number-pos))
         (cleaned (remove yen-ignore-char orig)))
    (string-to-number cleaned)))

(provide 'yen)
