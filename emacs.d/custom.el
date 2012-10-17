(add-to-list 'load-path "~/.emacs.d/custom/")
; automatic syntax check
(require 'flymake)
;(setq flymake-log-level 3)

(load "custom-c") ; C/C++ customization
