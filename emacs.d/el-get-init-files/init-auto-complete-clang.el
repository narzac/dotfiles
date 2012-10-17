(setq myoptdir "~/.emacs.d/")
(add-to-list 'load-path (concat myoptdir "AC"))
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories (concat myoptdir "AC/ac-dict"))

(require 'auto-complete-clang)

(setq ac-auto-start nil)
(setq ac-quick-help-delay 0.5)
;; (ac-set-trigger-key "TAB")
;; (define-key ac-mode-map  [(control tab)] 'auto-complete)
(define-key ac-mode-map  [(control tab)] 'auto-complete)
(defun my-ac-config ()
  (setq-default ac-sources '(ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers))
  (add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)
  ;; (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
  (add-hook 'ruby-mode-hook 'ac-ruby-mode-setup)
  (add-hook 'css-mode-hook 'ac-css-mode-setup)
  (add-hook 'auto-complete-mode-hook 'ac-common-setup)
  (global-auto-complete-mode t))
(defun my-ac-cc-mode-setup ()
  (setq ac-sources (append '(ac-source-clang ac-source-yasnippet) ac-sources)))
(add-hook 'c-mode-common-hook 'my-ac-cc-mode-setup)
;; ac-source-gtags
(my-ac-config)


;; (setq ac-clang-flags
;;	  (mapcar (lambda (item)(concat "-I" item))
;;			  (split-string
;;			   "
;; /usr/llvm-gcc-4.2/bin/../lib/gcc/i686-apple-darwin11/4.2.1/include
;;  /usr/include/c++/4.2.1
;;  /usr/include/c++/4.2.1/backward
;;  /usr/local/include
;;  /Applications/Xcode.app/Contents/Developer/usr/llvm-gcc-4.2/lib/gcc/i686-apple-darwin11/4.2.1/include
;;  /usr/include
;;  /System/Library/Frameworks
;;  /Library/Frameworks
;; "
;;			   )))

(defun my-ac-clang-mode-common-hook()
  (define-key c-mode-base-map (kbd "TAB") 'ac-complete-clang)
)
