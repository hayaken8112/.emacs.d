<<<<<<< HEAD
(defvar user-emacs-directory "~/.emacs.d/")
(global-set-key "\M-g" 'goto-line) ;指定の行に移る
=======
(defvar user-emacs-directory "home/hayaken/.emacs.d/")
;; ~/.emacs.d/site-lisp 以下全部読み込み
(let ((default-directory (expand-file-name "~/.emacs.d/site-lisp")))
  (add-to-list 'load-path default-directory)
  (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
      (normal-top-level-add-subdirs-to-load-path)))

(require 'init-loader)
(setq init-loader-show-log-after-init nil)
(init-loader-load "~/.emacs.d/inits")

;; auto-complete-clang 設定
(require 'auto-complete-config)
(require 'auto-complete-clang)
;; (ac-config-default)

;;補完キー指定
(ac-set-trigger-key "TAB")
;;ヘルプ画面が出るまでの時間（秒）
(setq ac-quick-help-delay 0.8)

(defun my-ac-cc-mode-setup ()
  ;;tなら自動で補完画面がでる．nilなら補完キーによって出る
  (setq ac-auto-start nil)
  (setq ac-clang-prefix-header "~/site-lisp/stdafx.pch")
  (setq ac-clang-flags '("-w" "-ferror-limit" "1"))
  (setq ac-sources (append '(ac-source-clang 
			     ac-source-yasnippet 
			     ac-source-gtags)
			   ac-sources)))

(defun my-ac-config ()
  (global-set-key "\M-/" 'ac-start)
  ;; C-n/C-p で候補を選択
  (define-key ac-complete-mode-map "\C-n" 'ac-next)
  (define-key ac-complete-mode-map "\C-p" 'ac-previous)

  (setq-default ac-sources '(ac-source-abbrev 
			     ac-source-dictionary 
			     ac-source-words-in-same-mode-buffers))
  (add-hook 'c++-mode-hook 'ac-cc-mode-setup)
  (add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)
  (add-hook 'c-mode-common-hook 'my-ac-cc-mode-setup)
  (add-hook 'ruby-mode-hook 'ac-css-mode-setup)
  (add-hook 'auto-complete-mode-hook 'ac-common-setup)
  (global-auto-complete-mode t))

(my-ac-config)
>>>>>>> b1b29afdcb4cb11ba7d46782a72078a25ed84243
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
;;c++
(add-hook 'c++-mode-hook

'(lambda ()
(c-set-style "k&r") ;;k&rスタイル
(setq c-auto-newline t) ;自動インデントを有効にする
(setq tab-width 4) ;;タブ幅４
(setq c-basic-offset 4) ;;基本タブ幅４
(setq indent-tabs-mode nil) ;インデントは空白文字で行う
(c-set-offset 'arglist-close 0) ;関数の引数リストの閉じ括弧はインデントしない
))

;;cppの全自動インデント設定
; style I want to use in c++ mode
(c-add-style "my-style" 
	     '("stroustrup"
	       (indent-tabs-mode . nil)        ; use spaces rather than tabs
	       (c-basic-offset . 4)            ; indent by four spaces
	       (c-offsets-alist . ((inline-open . 0)  ; custom indentation rules
				   (brace-list-open . 0)
				   (statement-case-open . +)))))

(defun my-c++-mode-hook ()
  (c-set-style "my-style")        ; use my-style defined above
  (auto-fill-mode)         
  (c-toggle-auto-hungry-state 1))

(add-hook 'c++-mode-hook 'my-c++-mode-hook)

;;Ruby-mode
(custom-set-variables
 '(ruby-insert-encoding-magic-comment nil))

(require 'ruby-mode)
(defun ruby-mode-set-encoding () nil)
(add-to-list 'auto-mode-alist '("\\.rb\\'" . ruby-mode))
(autoload 'ruby-mode "ruby-mode" "Major mode for editing Ruby code" t)

;Automatic indentation
(add-hook 'ruby-mode-hook
          '(lambda ()
             (setq tab-width 2)
             (setq ruby-indent-level tab-width)
             (setq ruby-deep-indent-paren-style nil)
             (local-set-key"\r" 'newline-and-indent)))
(defadvice ruby-indent-line (after unindent-closing-paren activate)
  (let ((column (current-column))
        indent offset)
    (save-excursion
      (back-to-indentation)
      (let ((state (syntax-ppss)))
        (setq offset (- column (current-column)))
        (when (and (eq (char-after) ?\))
                   (not (zerop (car state))))
          (goto-char (cadr state))
          (setq indent (current-indentation)))))
    (when indent
      (indent-line-to indent)
      (when (> offset 0) (forward-char offset)))))
(require 'ruby-block)
(ruby-block-mode t)
(setq ruby-block-highlight-toggle t)

;Electric commands




;;auto-installの設定
;;(when (require 'auto-install nil t)
  ;;インストールディレクトリの設定。初期値は~/.emacs.d/auto-install/
  ;;(setq auto-install-directory "~/.emacs.d/elisp/")
  ;;EmacsWikiに登録されているelispの名前を取得
  ;;(auto-install-update-emacswiki-package-name t)
  ;;必要であればプロキシの設定を行う
  ;;(set url-prozy-services '(("http" . "localhost:8339")))
;;install-elispの関数を利用可能にする
  ;;(auto-install-compatibility-setup))
	  
<<<<<<< HEAD

(put 'upcase-region 'disabled nil)
=======
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;行コピ
(global-set-key (kbd "M-k") 'copy-whole-line)

(defun keep-highlight-regexp (re)
  (interactive "sRegexp: \n")
  (make-face 'my-highlight-face)
  (set-face-foreground 'my-highlight-face "red")
  (set-face-background 'my-highlight-face "green")
  (defvar my-highlight-face 'my-highlight-face)
  (setq font-lock-set-defaults nil)
  (font-lock-set-defaults)
  (font-lock-add-keywords 'nil (list (list re 0 my-highlight-face t)))
  (font-lock-fontify-buffer))

(defun cancel-highlight-regexp ()
  (interactive)
  (setq font-lock-set-defaults nil)
  (font-lock-set-defaults)
  (font-lock-fontify-buffer))

(global-set-key "\C-s" 'keep-highlight-regexp)
(global-set-key "\C-d" 'cancel-highlight-regexp)
>>>>>>> b1b29afdcb4cb11ba7d46782a72078a25ed84243
