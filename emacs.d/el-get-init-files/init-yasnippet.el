;;; Snippets make typing fun
(require 'dropdown-list)

(yas/global-mode 1)

(yas/load-directory "~/.emacs.d/el-get/yasnippet/snippets")

(setq yas/prompt-functions '(yas/dropdown-prompt
							 yas/completing-prompt
							 yas/ido-prompt))

