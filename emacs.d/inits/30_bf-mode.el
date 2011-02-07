;;=======================================================================
;; @ bf-mode - dired でファイルの内容を表示する
;;=======================================================================
(require 'bf-mode)
(setq bf-mode-browsing-size 10000)                  ; 別ウィンドウに表示するサイズの上限
(setq bf-mode-except-ext '("\\.exe$" "\\.com$"))    ; 別ウィンドウに表示しないファイルの拡張子
(setq bf-mode-force-browse-exts                     ; 容量がいくつであっても表示して欲しいもの
      (append '("\\.texi$" "\\.el$")
              bf-mode-force-browse-exts))
(setq bf-mode-html-with-w3m t)                      ; html は w3m で表示する
(setq bf-mode-archive-list-verbose t)               ; 圧縮されたファイルを表示
(setq bf-mode-directory-list-verbose t)             ; ディレクトリ内のファイル一覧を表示
