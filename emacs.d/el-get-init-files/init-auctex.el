(add-to-list 'load-path "~/.emacs.d/el-get/auctex")
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)

(setq font-latex-fontify-script nil)
(setq font-latex-fontify-sectioning 'color)
; modify Beamer as well
(custom-set-faces
 '(font-latex-slide-title-face ((t (:inherit font-lock-type-face)))))

(setq TeX-PDF-mode t)
(when (string-match "apple-darwin" system-configuration)
;for OS X only
  (setq TeX-view-program-list
      '(("DVI Viewer" "open %o")
        ("PDF Viewer" "open %o")
        ("HTML Viewer" "open %o"))))

(setq preview-image-type 'png)
