;;; backup_each_save_config.el ---
;;
;; Filename: backup_each_save_config.el
;; Description:
;; Author: Manuel Schneckenreither
;; Maintainer:
;; Created: So Okt 27 17:01:15 2013 (+0100)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Mi Jan  8 20:43:44 2014 (+0100)
;;           By: Manuel Schneckenreither
;;     Update #: 3
;; URL:
;; Doc URL:
;; Keywords:
;; Compatibility:
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;;
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Change Log:
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:


;; backup each save
(add-hook 'before-save-hook 'force-backup-of-buffer)
(defun force-backup-of-buffer ()
  (setq buffer-backed-up nil))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; backup_each_save_config.el ends here
