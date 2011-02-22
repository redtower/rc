;;=======================================================================
;; @ howm
;;=======================================================================
(setq howm-menu-lang 'ja)
(global-set-key "\C-c,," 'howm-menu)

(mapc
 (lambda (f)
   (autoload f "howm" "Hitori Otegaru Wiki Modoki" t))
 '(howm-menu
   howm-list-all
   howm-list-recent
   howm-list-grep
   howm-create
   howm-keyword-to-kill-ring))
(eval-after-load "howm-mode"                    ; リンクを TAB で辿る
  '(progn
     (define-key howm-mode-map [tab] 'action-lock-goto-next-link)
     (define-key howm-mode-map [(meta tab)] 'action-lock-goto-previous-link)))

(setq howm-list-recent-title t)                 ; 「最近のメモ」一覧時にタイトル表示
(setq howm-list-all-title t)                    ; 全メモ一覧時にタイトル表示
(setq howm-menu-expiry-hours 2)                 ; メニューを 2 時間キャッシュ
(add-hook 'howm-mode-on-hook
;          'auto-fill-mode                       ; howm の時は auto-fill にする
          '(lambda () (auto-fill-mode -1))      ; howm の時は auto-fill でなくする
          )
(setq howm-view-summary-persistent nil)         ; RET でファイルを開く際, 一覧バッファを消す
                                                ; C-u RET なら残る
(setq howm-menu-schedule-days 7)                ; メニューの予定表の表示範囲（7 日前から）
(setq howm-menu-schedule-days-before 3)         ; メニューの予定表の表示範囲（3 日後まで）
(setq howm-file-name-format                     ; howm のファイル名（1 メモ 1 ファイル）
      "%Y/%m/%Y-%m-%d-%H%M%S.howm")
(setq howm-view-grep-parse-line
      "^\\(\\([a-zA-Z]:/\\)?[^:]*\\.howm\\):\\([0-9]*\\):\\(.*\\)$")
(setq howm-excluded-file-regexp                 ; 検索しないファイルの正規表現
      "/\\.#\\|[~#]$\\|\\.bak$\\|/CVS/\\|\\.doc$\\|\\.pdf$\\|\\.ppt$\\|\\.xls$")

;;=======================================================================
;; @ 保存時にファイルサイズが 0 なら削除（howm の時）
;;=======================================================================
; いちいち消すのも面倒なので内容が 0 ならファイルごと削除する
(if (not (memq 'delete-file-if-no-contents after-save-hook))
    (setq after-save-hook
          (cons 'delete-file-if-no-contents after-save-hook)))
(defun delete-file-if-no-contents ()
  (when (and
         (buffer-file-name (current-buffer))
         (string-match "\\.howm" (buffer-file-name (current-buffer)))
         (= (point-min) (point-max)))
    (delete-file
     (buffer-file-name (current-buffer)))))

;;=======================================================================
;; @ ElScreen-howm
;;=======================================================================
(require 'elscreen-howm)
