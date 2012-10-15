;;narzac .emacs file
(server-start)
(setq visible-bell t)
(setq debug-on-error t)

(setq exec-path (cons "/usr/local/bin" exec-path))
(setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))
(setq exec-path (cons "/usr/texbin" exec-path))
(setenv "PATH" (concat "/usr/texbin:" (getenv "PATH")))
(setq exec-path (cons "/Applications/Emacs.app/Contents/MacOS/bin" exec-path))
(setenv "PATH" (concat "/Applications/Emacs.app/Contents/MacOS/bin:" (getenv "PATH")))

(defalias 'yes-or-no-p 'y-or-n-p)

;; on to the visual settings
(setq inhibit-splash-screen t)			 ; no splash screen
(setq initial-scratch-message nil)     ; no scratch message
(setq inhibit-startup-message t)       ; no startup message

(line-number-mode 1)			; have line numbers and
(column-number-mode 1)			; column numbers in the mode line


(tool-bar-mode -1)			; no tool bar with icons
(scroll-bar-mode -1)			; no scroll bars
(unless (string-match "apple-darwin" system-configuration)
	;; on mac, there's always a menu bar drown, don't have it empty
	(menu-bar-mode -1))

;; choose font for macosx, choose for other OS later on.
(if (string-match "apple-darwin" system-configuration)
	(set-frame-font "Menlo-12")
	(set-face-font 'default "Monaco-12")
	(set-face-font 'default "Monospace-10"))

(global-hl-line-mode 1)			; highlight current line
(set-face-background 'hl-line "gray6") ;; Great for black background
(global-linum-mode -1)			; don't add line numbers on the left

;; under mac, have Command as Meta and keep Option for localized input
(when (string-match "apple-darwin" system-configuration)
	(setq mac-allow-anti-aliasing t)
	(setq mac-command-modifier 'meta)
	(setq mac-option-modifier 'none))

;; Use the clipboard, pretty please, so that copy/paste "works"
(setq x-select-enable-clipboard t)

;; Navigate windows with M-<arrows>
(windmove-default-keybindings 'meta)
(setq windmove-wrap-around t)

;; whenever an external process changes a file underneath emacs, and there
;; was no unsaved changes in the corresponding buffer, just revert its
;; content to reflect what's on-disk.
(global-auto-revert-mode 1)

;; M-x shell is a nice shell interface to use, let's make it colorful.  If
;; you need a terminal emulator rather than just a shell, consider M-x term
;; instead.
(require 'eshell)
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; use ido for minibuffer completion
(require 'ido)
(ido-mode t)
(setq ido-save-directory-list-file "~/.emacs.d/.ido.last")
(setq ido-enable-flex-matching t) ;; fuzy matching
(setq ido-use-filename-at-point 'guess)
(setq ido-show-dot-for-dired t)
(setq ido-enable-last-directory-history nil) ; forget latest selected directory names

; utf8
(require 'un-define "un-define" t)
(setq current-language-environment "UTF-8")
(set-buffer-file-coding-system 'utf-8 'utf-8-unix)
(set-default buffer-file-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)
(prefer-coding-system 'utf-8-unix)
(set-default default-buffer-file-coding-system 'utf-8-unix)

; common lisp goodies
(require 'cl)

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
							 ("marmalade" . "http://marmalade-repo.org/packages/")
							 ("melpa" . "http://melpa.milkbox.net/packages/")))

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(require 'el-get)

;; where to put package customizations ( same as :after and/or :before properties.
(setq el-get-user-package-directory "~/.emacs.d/el-get-init-files")

(unless (require 'el-get nil t)
	(url-retrieve
	 "https://raw.github.com/dimitri/el-get/master/el-get-install.el"
	 (lambda (s)
	 (let (el-get-master-branch)
		 (goto-char (point-max))
		 (eval-print-last-sexp)))))


;; extra recipes for packages unknown to el-get (yet)
(setq el-get-sources
		'((:name jade-mode
			 :type git
			 :url "https://github.com/brianc/jade-mode.git"
			 :load "jade-mode.el"
			 :compile ("jade-mode.el")
			 :features jade-mode)
	(:name stylus-mode
			 :type git
			 :url "https://github.com/brianc/jade-mode.git"
			 :load "sws-mode.el"
			 :compile ("sws-mode.el")
			 :features stylus-mode)
	(:name auto-complete-auctex
			 :type git
			 :url "https://github.com/monsanto/auto-complete-auctex.git"
			 :compile ("auto-complete-auctex.el"))))


;; list all packages you want installed
(setq my-packages
		(append
		 '(el-get
				 smex
				 auctex
				 rainbow-mode
				 color-theme
				 color-theme-tango-2
				 color-theme-railscasts
				 color-theme-subdued
				 color-theme-zen-and-art
				 smarttabs
				 css-mode
				 js2-mode
				 yasnippet
				 auto-complete-yasnippet
				 auto-complete
				 zencoding-mode
;				 auto-complete-auctex
;				 ac-math
				 )
		 (mapcar 'el-get-source-name el-get-sources)))

(el-get-cleanup my-packages)
(el-get 'sync   my-packages)
;(load-file "~/.emacs.d/color-theme-blackboard.el")
;(color-theme-blackboard)
(color-theme-tango-2)


;; Trailing whitespace is unnecessary
(add-hook 'before-save-hook (lambda () (whitespace-cleanup)))

;; Trash can support
(setq delete-by-moving-to-trash t)

;; `brew install aspell --lang=en` (instead of ispell)
(setq-default ispell-program-name "aspell")
(setq ispell-list-command "list")
(setq ispell-extra-args '("--sug-mode=ultra"))
(setq blink-cursor-mode -1)
(setq frame-title-format '(buffer-file-name "%f" ("%b")))
(setq whitespace-line-column 80)
(setq backup-directory-alist `(("." . ,(concat user-emacs-directory "backups"))))

;; Highlight matching parentheses when the point is on them.
(show-paren-mode 1)

(defun lorem ()
	"Insert a lorem ipsum."
	(interactive)
	(insert "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do "
			"eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim"
			"ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut "
			"aliquip ex ea commodo consequat. Duis aute irure dolor in "
			"reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla "
			"pariatur. Excepteur sint occaecat cupidatat non proident, sunt in "
			"culpa qui officia deserunt mollit anim id est laborum."))
