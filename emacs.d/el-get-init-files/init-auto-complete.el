(add-to-list 'load-path "~/.emacs.d/el-get/yasnippet/")
(add-to-list 'load-path "~/.emacs.d/el-get/auto-complete-yasnippet/")
(require 'yasnippet)
(require 'auto-complete-config)
(require 'auto-complete-yasnippet)


(add-to-list 'ac-dictionary-directories "~/.emacs.d/el-get/auto-complete/dict/")
(ac-config-default)
(define-key ac-mode-map (kbd "TAB") 'auto-complete)
(ac-set-trigger-key "TAB")
(setq ac-auto-show-menu nil)
(setq ac-dwim t)                        ;Do what i mean
(setq ac-override-local-map nil)        ;don't override local map


;; The mode that automatically startup.
(setq ac-modes
		'(emacs-lisp-mode lisp-interaction-mode lisp-mode scheme-mode
						html-mode js-mode js2-mode
						c-mode cc-mode c++-mode java-mode
						perl-mode cperl-mode python-mode ruby-mode
						ecmascript-mode javascript-mode php-mode css-mode
						makefile-mode sh-mode fortran-mode f90-mode ada-mode
						xml-mode sgml-mode
						emms-tag-editor-mode
						asm-mode
						org-mode))

;; The sources for common all mode.
(custom-set-variables
 '(ac-sources
	 '(
	 ac-source-yasnippet ;this source need file `auto-complete-yasnippet.el'
	 ac-source-imenu
	 ac-source-abbrev
	 ac-source-words-in-buffer
	 ac-source-files-in-current-dir
	 ac-source-filename
	 )))


(global-auto-complete-mode t)
