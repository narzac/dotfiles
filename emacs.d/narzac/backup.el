;; Backup files
;; http://emacswiki.org/emacs/BackupDirectory

;; Prevent creation  of lock files, which prevents multiple users from saving the same file.
;; http://www.gnu.org/software/emacs/manual/html_node/emacs/Interlocking.html#Interlocking
;; if present grunt watch & gotube watch fails, temporarily nil, revert it back later
(setq create-lockfiles nil)

(setq temporary-file-directory "~/.emacs.d/tmp/.saves")
(make-directory temporary-file-directory t)

(setq  auto-save-file-name-transforms
	  `((".*" ,temporary-file-directory t)))

(setq auto-save-list-file-prefix ".auto-saves-")


;;http://www.gnu.org/software/emacs/manual/html_node/tramp/Auto_002dsave-and-Backup.html
(setq tramp-backup-directory-alist backup-directory-alist)
(setq tramp-auto-save-directory auto-save-file-name-transforms)


(setq version-control t     ;; Use version numbers for backups.
      kept-new-versions 10  ;; Number of newest versions to keep.
      kept-old-versions 0   ;; Number of oldest versions to keep.
      delete-old-versions t ;; Don't ask to delete excess backup versions.
      backup-by-copying t)  ;; Copy all files, don't rename them. don't clobber symlinks

;; (setq auto-save-default t)	 ;; Yes auto save good
;; (setq auto-save-interval 100) ;; Number of input chars between auto-saves
;; (setq auto-save-timeout 300)  ;; Number of seconds idle time before auto-save
(setq auto-save-default nil)

;; http://stackoverflow.com/questions/151945/how-do-i-control-how-emacs-makes-backup-files
; Default and per-save backups go here:
(setq backup-directory-alist '(("" . "~/.emacs.d/tmp/backup/per-save")))

(defun force-backup-of-buffer ()
  ;; Make a special "per session" backup at the first save of each
  ;; emacs session.
  (when (not buffer-backed-up)
    ;; Override the default parameters for per-session backups.
    (let ((backup-directory-alist '(("" . "~/.emacs.d/tmp/backup/per-session")))
	  (kept-new-versions 3))
      (backup-buffer)))
  ;; Make a "per save" backup on each save.  The first save results in
  ;; both a per-session and a per-save backup, to keep the numbering
  ;; of per-save backups consistent.
  (let ((buffer-backed-up nil))
    (backup-buffer)))

(add-hook 'before-save-hook  'force-backup-of-buffer)
