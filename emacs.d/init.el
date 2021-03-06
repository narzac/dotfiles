;; TODO: install a smarttab, but only use  space as a tab

(add-to-list 'load-path "~/.emacs.d/config")
;; General configs
(load "theme")
(load "custom")
(load "backup")
(load "bindings")
(load "utf8")
(load "functions")
(load "env")

;; INSTALL A FEW PACKAGES WITH PACKAGE MANAGER
;; list the packages you want
(setq package-list '(smex css-mode rainbow-mode flymake-cursor
						  buffer-move auctex
						  go-mode flymake-go  less-css-mode markdown-mode))

;; list the repositories containing them
(setq package-archives '(("elpa" . "http://tromey.com/elpa/")
						 ("gnu" . "http://elpa.gnu.org/packages/")
						 ("marmalade" . "http://marmalade-repo.org/packages/")))

;; activate all the packages (in particular autoloads)
(package-initialize)

;; fetch the list of packages available
(when (not package-archive-contents)
  (package-refresh-contents))

;; install the missing packages
(dolist (package package-list)
  (when (not (package-installed-p package))
	(package-install package)))

;; CONFIGURE INSTALLED PACKAGES
;; use ido for minibuffer completion
(require 'cl)

(require 'ido)
(ido-mode t)
(setq ido-save-directory-list-file "~/.emacs.d/tmp/.ido.last")
(setq ido-enable-flex-matching t) ;; fuzy matching
(setq ido-use-filename-at-point 'guess)
(setq ido-show-dot-for-dired t)
(setq ido-enable-last-directory-history nil) ;; forget latest selected directory names

(require 'smex)
(setq smex-save-file "~/.emacs.d/tmp/.smex-items")
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

;; M-x shell is a nice shell interface to use, let's make it colorful.  If
;; you need a terminal emulator rather than just a shell, consider M-x term
;; instead.
(require 'eshell)
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;;css-mode
(setq cssm-indent-function #'cssm-c-style-indenter)
(setq cssm-indent-level 2)


;; yasnippet
(add-to-list 'load-path "~/.emacs.d/vendor/yasnippet")
(require 'yasnippet)
(add-to-list 'load-path "~/.emacs.d/vendor")
(require 'dropdown-list)
(yas/global-mode 1)
(yas/load-directory "~/.emacs.d/config/mysnippets")
(setq yas/prompt-functions '(yas/dropdown-prompt
							 yas/completing-prompt
							 yas/ido-prompt))
;; ;;auto-complete
(add-to-list 'load-path "~/.emacs.d/vendor/auto-complete-popup")
(add-to-list 'load-path "~/.emacs.d/vendor/auto-complete")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/config/myac-dicts")
(setq ac-comphist-file  "~/.emacs.d/tmp/ac-comphist.dat")
(ac-config-default)
(global-auto-complete-mode t)

(define-key ac-mode-map (kbd "TAB") 'auto-complete)
(ac-set-trigger-key "TAB")
(setq ac-auto-show-menu nil)
;;(setq ac-dwim t) ;;Do what i mean
(setq ac-override-local-map nil)        ;;don't override local map
(setq ac-auto-start nil)
(setq ac-quick-help-delay 0.5)

;; The modes that AC will start automatically.
(setq ac-modes
	  '(emacs-lisp-mode lisp-interaction-mode lisp-mode scheme-mode
						html-mode js-mode js2-mode
						c-mode cc-mode c++-mode java-mode
						perl-mode cperl-mode python-mode ruby-mode
						ecmascript-mode javascript-mode php-mode css-mode
						makefile-mode sh-mode fortran-mode f90-mode ada-mode
						xml-mode sgml-mode go-mode
						emms-tag-editor-mode
						asm-mode
						org-mode jade-mode stylus-mode sws-mode haskell-mode))

;; The sources for common all mode.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-sources
   (quote
	(ac-source-abbrev ac-source-css-property ac-source-dictionary ac-source-features ac-source-filename ac-source-words-in-buffer)) t)
 '(custom-safe-themes
   (quote
	("dd4db38519d2ad7eb9e2f30bc03fba61a7af49a185edfd44e020aa5345e3dca7" default))))

;; auto-complete hooks for emacs-lisp
(add-hook 'emacs-lisp-mode (lambda () (add-to-list 'ac-sources '(ac-source-functions ac-source-symbols ac-source-variables ))))

;; auto-complete-yasnippet integration
(add-to-list 'load-path "~/.emacs.d/vendor")
(require 'auto-complete-yasnippet)
(setq ac-sources (append '(ac-source-yasnippet) ac-sources))

;; ;;auto-complete-auctex integration
;; (add-to-list 'load-path "~/.emacs.d/vendor/auto-complete-auctex")
;; (require 'auto-complete-auctex)

;; js2-mode
(add-to-list 'load-path "~/.emacs.d/vendor/js2-mode")
(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(setq js2-cleanup-whitespace t)
(setq js2-basic-offset 2)
(setq js2-bounce-indent-p t)
;; Special improvements using the mooz fork
;; https://github.com/mooz/js2-mode
;;(setq js2-pretty-multiline-declarations t )
;;(setq js2-consistent-level-indent-inner-bracket-p t)
;;(setq js2-use-ast-for-indentation-p t)
(eval-after-load 'js2-mode
  '(define-key js2-mode-map (kbd "RET") 'js2-line-break))


(require 'flymake)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flymake-errline ((((class color)) (:background "#550000" :overline "#550000" :underline "#550000"))))
 '(flymake-warnline ((((class color)) (:background "#555500" :overline "#555500" :underline "#555500")))))


;;(setq flymake-log-level 3)
(require 'flymake-cursor)

;; js-hint mode
(add-to-list 'load-path "~/.emacs.d/vendor/jshint-mode")
(require 'flymake-jshint)
(add-hook 'javascript-mode-hook
		  (lambda () (flymake-mode t)))

;; ;; Turns on flymake for all files which have a flymake mode
;; (add-hook 'find-file-hook 'flymake-find-file-hook)

;; Emmet mode
(add-to-list 'load-path "~/.emacs.d/vendor/emmet-mode")
(require 'emmet-mode)
(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.
(add-hook 'emmet-mode-hook (lambda () (setq emmet-indentation 2))) ;; indent 2 spaces.
(setq emmet-move-cursor-between-quotes t) ;; default nil

;;buffer-move
(require 'buffer-move)

;;rainbow-mode
(require 'rainbow-mode )
(add-hook 'css-mode-hook 'rainbow-mode)
(add-hook 'js2-mode 'rainbow-mode)
(add-hook 'sgml-mode-hook 'rainbow-mode)
(global-set-key (kbd "C-j") 'zencoding-expand-line)
;; auto start html mode for  *.tmpl
(add-to-list 'auto-mode-alist '("\\.tmpl$" . html-mode))

;; multiple cursor
(add-to-list 'load-path "~/.emacs.d/vendor/multiple-cursors")
(require 'multiple-cursors)
;;When you have an active region that spans multiple lines,
;; the following will add a cursor to each line:
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
;;When you want to add multiple cursors not based on continuous lines,
;; but based on keywords in the buffer, use:
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
;;To get out of multiple-cursors-mode, press <return> or C-g.
;; The latter will first disable multiple regions before disabling multiple cursors.
;; If you want to insert a newline in multiple-cursors-mode, use C-j.
(setq mc/list-file "~/.emacs.d/tmp/.mc-lists.el")


;; TODO: these two line is auto generated, move to an appropriate configuration
(setq line-spacing 5)
(put 'downcase-region 'disabled nil)

;; haskell-mode
;; brew install  ghc
;; (add-to-list 'load-path "~/.emacs.d/vendor/haskell-mode/")
;; (require 'haskell-mode-autoloads)
;; (add-to-list 'Info-default-directory-list "~/.emacs.d/vendor/emacs/haskell-mode/")
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

;; yaml-mode
(add-to-list 'load-path "~/.emacs.d/vendor/yaml-mode/")
(require 'yaml-mode )

;; (add-to-list 'load-path "/usr/local/share/emacs/site-lisp")
;; (require 'tex-site)

;; (setq font-latex-fontify-script nil)
;; (setq font-latex-fontify-sectioning 'color)
;; ;; modify Beamer as well
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(font-latex-slide-title-face ((t (:inherit font-lock-type-face)))))

;; (setq TeX-PDF-mode t)
;; (when (string-match "apple-darwin" system-configuration)
;;   ;;for OS X only
;;   (setq TeX-view-program-list
;;         '(("DVI Viewer" "open %o")
;;           ("PDF Viewer" "open %o")
;;           ("HTML Viewer" "open %o"))))

;; (setq preview-image-type 'png)

;; editorconfig support
(add-to-list 'load-path "~/.emacs.d/vendor/editorconfig-emacs/")
(load "editorconfig")

;; scss mode
;; show emacs where to find sass executable
(setq exec-path (cons (expand-file-name "~/.rvm/gems/ruby-1.9.3-p327/bin") exec-path))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/scss-mode/"))
(autoload 'scss-mode "scss-mode")
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))
;; disable auto compile on save
(setq scss-compile-at-save nil)

;; web-mode
;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/web-mode/"))
;; (require 'web-mode)
;; (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.tpl.html\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.hbs\\'" . web-mode))

;; ;; edit plain HTML files with web-mode
;; (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;; ;; indentation
;; (setq web-mode-markup-indent-offset 2)
;; (setq web-mode-css-indent-offset 2)
;; (setq web-mode-code-indent-offset 2)
;; (setq web-mode-style-padding 1)
;; (setq web-mode-script-padding 1)
;; (setq web-mode-block-padding 0)

(setq-default ispell-program-name "aspell")
