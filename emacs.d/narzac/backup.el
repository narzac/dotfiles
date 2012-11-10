;; Backup files
;;http://emacswiki.org/emacs/BackupDirectory
;; TODO: Make auto-save files go under tmp/.saves/ directory not tmp/
(setq temporary-file-directory "~/.emacs.d/tmp/.saves")

(make-directory temporary-file-directory t)
(setq backup-directory-alist ; don't litter my fs tree
	  `(("." . ,temporary-file-directory)))

(setq  auto-save-file-name-transforms
	  `((".*" ,temporary-file-directory t)))

(setq auto-save-list-file-prefix ".auto-saves-")

;;http://www.gnu.org/software/emacs/manual/html_node/tramp/Auto_002dsave-and-Backup.html
(setq tramp-backup-directory-alist backup-directory-alist)
(setq tramp-auto-save-directory auto-save-file-name-transforms)

(setq
   backup-by-copying t      ; don't clobber symlinks
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups

(setq auto-save-default t)		; Yes auto save good
(setq auto-save-interval 100) ; Number of input chars between auto-saves
(setq auto-save-timeout 300) ; Number of seconds idle time before auto-save
