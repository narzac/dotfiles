(server-start)
(setq visible-bell t)
(setq debug-on-error t)

;; This enables the colors
 ;; Turn on font-lock in all modes that support it
 (if (fboundp 'global-font-lock-mode)
     (global-font-lock-mode t))
 (setq font-lock-make-faces t)
 (setq font-lock-maximum-decoration t)

(setq scroll-step 1)		   ; Scroll one line at a time damnit!

(defalias 'yes-or-no-p 'y-or-n-p)

;; on to the visual settings
(setq inhibit-splash-screen t)           ; no splash screen
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
