;;=======================================================================
;; @ ファイル名コーディング、ロケールコーディング
;;=======================================================================
(cond
 ((is_mac)
  (require 'ucs-normalize)
  (setq file-name-coding-system 'utf-8-hfs)
  (setq locale-coding-system    'utf-8-hfs))
 ((is_windows)
  (setq file-name-coding-system 'shift_jis)
  (setq locale-coding-system    'utf-8))
 (t
  (setq file-name-coding-system 'utf-8)
  (setq locale-coding-system    'utf-8))
)
