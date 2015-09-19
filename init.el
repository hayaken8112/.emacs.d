(defvar user-emacs-directory "~/.emacs.d/")
;;load-pathを追加する関数を定義
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
	      (expand-file-name (concat user-emacs-directory path))))
	(add-to-list 'load-path default-directory)
	(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
	    (normal-top-level-add-subdirs-to-load-path))))))

;;引数のディレクトリとそのサブディレクトリをload-pathに追加
(add-to-load-path "elisp" "conf" "public_repos")
;;テーマ設定
(when (require 'color-theme nil t)
  (color-theme-initialize)
  (color-theme-pok-wob))
;;文字コード指定
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)
;;タイトルバーにファイルのフルパス表示
(setq frame-title-format "%f")
;;現在行のハイライト
(defface my-hl-line-face
  ;;背景色がdarkなら紺
  '((((class color) (background dark))
     (:background "NavyBlue" t))
    ;;背景がlightならば緑
    (((class color) (background light))
     (:background "LightGoldenrodYellow" t))
    (t (:blod t)))
  "hl-line's my face")
(setq hl-line-face 'my-hl-line-face)
(global-hl-line-mode t)



;;対応するカッコ表示
(show-paren-mode 1)
;;行番号桁番号表示
(line-number-mode t)(column-number-mode t)

;;Auto Complete Modeの設定

;;Cの全自動インデント設定
(add-hook 'c-mode-hook

'(lambda ()
(c-set-style "k&r") ;;k&rスタイル
(setq c-auto-newline t) ;自動インデントを有効にする
(setq tab-width 4) ;;タブ幅４
(setq c-basic-offset 4) ;;基本タブ幅４
(setq indent-tabs-mode nil) ;インデントは空白文字で行う
(c-set-offset 'arglist-close 0) ;関数の引数リストの閉じ括弧はインデントしない
))

	  
