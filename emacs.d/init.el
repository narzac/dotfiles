
;; TODO
;; install a smarttab, but only use  space as a tab
;;

(add-to-list 'load-path "~/.emacs.d/narzac")
;; General configs
(load "theme")
(load "custom")
(load "backup")
(load "bindings")
(load "utf8")
(load "functions")
(load "env")
;; Mode specific config
(load "config-cc")

	      ;;;;;;;;;;;;;;;;; PACKAGE.EL INSTALL   - START  ;;;;;;;;;;;;;;;;;

; list the packages you want
(setq package-list '(smex css-mode rainbow-mode flymake-cursor color-theme
			  auctex zencoding-mode buffer-move
			  go-mode flymake-go sml-mode less-css-mode markdown-mode))

; list the repositories containing them
(setq package-archives '(("elpa" . "http://tromey.com/elpa/")
			 ("gnu" . "http://elpa.gnu.org/packages/")
			 ("marmalade" . "http://marmalade-repo.org/packages/")))

; activate all the packages (in particular autoloads)
(package-initialize)

; fetch the list of packages available
(when (not package-archive-contents)
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (when (not (package-installed-p package))
    (package-install package)))

	      ;;;;;;;;;;;;;;;;; PACKAGE.EL INSTALL   - END   ;;;;;;;;;;;;;;;;;;;

	      ;;;;;;;;;;;;;;;;; PACKAGE CONFIGURE - START  ;;;;;;;;;;;;;;;;;;;;;

;; use ido for minibuffer completion
(require 'cl)

(require 'ido)
(ido-mode t)
(setq ido-save-directory-list-file "~/.emacs.d/tmp/.ido.last")
(setq ido-enable-flex-matching t) ;; fuzy matching
(setq ido-use-filename-at-point 'guess)
(setq ido-show-dot-for-dired t)
(setq ido-enable-last-directory-history nil) ; forget latest selected directory names

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
(require 'dropdown-list)
(yas/global-mode 1)
(yas/load-directory "~/.emacs.d/narzac/snippets")
(setq yas/prompt-functions '(yas/dropdown-prompt
			     yas/completing-prompt
			     yas/ido-prompt))

;; ;;auto-complete
(add-to-list 'load-path "~/.emacs.d/vendor/auto-complete")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/narzac/ac-dict")
(setq ac-comphist-file  "~/.emacs.d/tmp/ac-comphist.dat")
(ac-config-default)
(global-auto-complete-mode t)

(define-key ac-mode-map (kbd "TAB") 'auto-complete)
(ac-set-trigger-key "TAB")
(setq ac-auto-show-menu nil)
;(setq ac-dwim t)                        ;Do what i mean
(setq ac-override-local-map nil)        ;don't override local map
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
				  org-mode jade-mode stylus-mode sws-mode))

;; The sources for common all mode.
(custom-set-variables
 '(ac-sources
	 '(
	   ac-source-abbrev
	   ac-source-css-property
	   ac-source-dictionary
	   ac-source-features
	   ac-source-filename
;          ac-source-files-in-current-dir ;; eshell
	   ac-source-words-in-buffer
;          ac-source-words-in-same-mode-buffers
	   )))

;; auto-complete hooks for emcas-lisp
(add-hook 'emacs-lisp-mode (lambda () (add-to-list 'ac-sources '(ac-source-functions ac-source-symbols ac-source-variables ))))

;; auto-complete-yasnippet integration
(require 'auto-complete-yasnippet)
(setq ac-sources (append '(ac-source-yasnippet) ac-sources))

;;auto-complete-auctex integration
(add-to-list 'load-path "~/.emacs.d/vendor/auto-complete-auctex")
(require 'auto-complete-auctex)

;auto-complete-clang integration
(require 'auto-complete-clang)
(setq ac-clang-flags
	  (mapcar (lambda (item)(concat "-I" item))
			  (split-string
			   "
.
./inc
./include
/usr/llvm-gcc-4.2/bin/../lib/gcc/i686-apple-darwin11/4.2.1/include
/usr/include/c++/4.2.1
/usr/include/c++/4.2.1/backward
/usr/local/include
/Applications/Xcode.app/Contents/Developer/usr/llvm-gcc-4.2/lib/gcc/i686-apple-darwin11/4.2.1/include
/usr/include
/System/Library/Frameworks
/Library/Frameworks
/usr/clang-ide/lib/c++/v1
"
			   )))

;; c++11 for autocomplete-clang
(setq ac-clang-flags (append '( "-std=c++11" "-stdlib=libc++" ) ac-clang-flags))

(defun my-ac-cc-mode-setup ()
  (setq ac-sources (append '(ac-source-clang) ac-sources)))

(setq clang-completion-suppress-error 't)
(add-hook 'c-mode-common-hook 'my-ac-cc-mode-setup)

;; js2-mode
(add-to-list 'load-path "~/.emacs.d/vendor/js2-mode")
(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(setq js2-cleanup-whitespace t)
(setq js2-basic-offset 2)
(setq js2-bounce-indent-p t)
;; Special improvements using the mooz fork
;; https://github.com/mooz/js2-mode
(setq js2-consistent-level-indent-inner-bracket-p t)
(setq js2-use-ast-for-indentation-p t)

(require 'flymake)
(custom-set-faces
 '(flymake-errline ((((class color)) (:background "#550000" :overline "#550000" :underline "#550000"))))
 '(flymake-warnline ((((class color)) (:background "#555500" :overline "#555500" :underline "#555500")))))


;(setq flymake-log-level 3)
(require 'flymake-cursor)

(require 'tex-site)

(setq font-latex-fontify-script nil)
(setq font-latex-fontify-sectioning 'color)
; modify Beamer as well
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-latex-slide-title-face ((t (:inherit font-lock-type-face)))))

(setq TeX-PDF-mode t)
(when (string-match "apple-darwin" system-configuration)
;for OS X only
  (setq TeX-view-program-list
      '(("DVI Viewer" "open %o")
	("PDF Viewer" "open %o")
	("HTML Viewer" "open %o"))))

(setq preview-image-type 'png)

;; jade-mode &  stylus-mode
(add-to-list 'load-path "~/.emacs.d/vendor/jade-mode")
(require 'sws-mode)
(require 'jade-mode)
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))
(require 'stylus-mode)

;; js-hint mode
(add-to-list 'load-path "~/.emacs.d/vendor/jshint-mode")
(require 'flymake-jshint)
(add-hook 'javascript-mode-hook
     (lambda () (flymake-mode t)))

;; Turns on flymake for all files which have a flymake mode
;(add-hook 'find-file-hook 'flymake-find-file-hook)

;; Zencoding mode

(add-to-list 'load-path "~/emacs.d/vendor/zencoding-mode-0.5.1")
(require 'zencoding-mode)
(add-hook 'sgml-mode-hook 'zencoding-mode) ;; Auto-start on any markup modes

;;buffer-move
(require 'buffer-move)

;;rainbow-mode
(require 'rainbow-mode )
(add-hook 'css-mode-hook 'rainbow-mode)
(add-hook 'js2-mode 'rainbow-mode)
(add-hook 'sgml-mode-hook 'rainbow-mode)


;; auto start tmpl
(add-to-list 'auto-mode-alist '("\\.tmpl$" . html-mode))
	      ;;;;;;;;;;;;;;;;; PACKAGE CONFIGURE - END   ;;;;;;;;;;;;;;;;;;;;;

(setq line-spacing 5)
(put 'downcase-region 'disabled nil)
