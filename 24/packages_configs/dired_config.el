;;; dired_config.el ---
;;
;; Filename: dired_config.el
;; Description:
;; Author: Manuel Schneckenreither
;; Maintainer:
;; Created: Di Mär  4 06:35:38 2014 (+0100)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Mi Mär 26 11:03:53 2014 (+0100)
;;           By: Manuel Schneckenreither
;;     Update #: 15
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
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:


;; reuse the same buffer

(put 'dired-find-alternate-file 'disabled nil)


;; distinguishing dired mode buffers from others
(add-hook 'dired-mode-hook 'ensure-buffer-name-ends-in-slash)
(defun ensure-buffer-name-ends-in-slash ()
  "change buffer name to end with slash"
  (let ((name (buffer-name)))
    (if (not (string-match "/$" name))
        (rename-buffer (concat name "/") t))))


(defun dired-open-in-external-app ()
  "Open the current file or dired marked files in external app."
  (interactive)
  (let ( doIt
         (myFileList
          (cond
           ((string-equal major-mode "dired-mode") (dired-get-marked-files))
           (t (list (buffer-file-name))) ) ) )

    (setq doIt (if (<= (length myFileList) 5)
                   t
                 (y-or-n-p "Open more than 5 files?") ) )

    (when doIt
      (cond
       ((string-equal system-type "windows-nt")
        (mapc (lambda (fPath) (w32-shell-execute "open" (replace-regexp-in-string "/" "\\" fPath t t)) ) myFileList)
        )
       ((string-equal system-type "darwin")
        (mapc (lambda (fPath) (shell-command (format "open \"%s\"" fPath)) )  myFileList) )
       ((string-equal system-type "gnu/linux")
        (mapc (lambda (fPath) (let ((process-connection-type
                                     nil)) (start-process "" nil "xdg-open" fPath)) )
              myFileList))))))


;; local hook
(add-hook 'dired-mode-hook
          (lambda ()
            ;; When moving to parent directory by `^´, Dired by
            ;; default creates a new buffer for each movement up. The
            ;; following rebinds `^´ to use the same buffer.

            (define-key dired-mode-map (kbd "^")
              (lambda () (interactive) (find-alternate-file "..")))
                                        ; was dired-up-directory
            (define-key dired-mode-map (kbd "o") 'dired-open-in-external-app)
            ))


;; dired-a provides support functions, including archiving, for dired
(load "dired-a")

;; Alist with information how to add files to an archive (from dired-a)
;; Each element has the form (REGEXP ADD-CMD NEW-CMD). If REGEXP matches
;; the file name of a target, that target is an archive and ADD-CMD is a command
;; that adds to an existing archive and NEW-CMD is a command that makes a new
;; archive (overwriting an old one if it exists). ADD-CMD and NEW-CMD are:
;; 1. Nil (meaning we cannot do this for this type of archive) (one of
;;    ADD-CMD and NEW-CMD must be non-nil).
;; 2. A symbol that must be a function e.g. dired-do-archive-op.
;; 3. A format string with two arguments, the source files concatenated into
;;    a space separated string and the target archive.
;; 4. A list of strings, the command and its flags, to which the target and
;;    the source-files are concatenated."
(setq dired-to-archive-copy-alist
      '(("\\.sh\\(ar\\|[0-9]\\)*$" nil "shar %s > %s")
    ("\\.jar$" ("jar" "uvf") ("jar" "cvf"))
    ("\\.tar$" ("tar" "-uf") ("tar" "-cf"))
    ("\\.tgz$\\|\\.tar\\.g?[zZ]$" ("tar" "-uf %s" "|" "gzip > %s") ("tar" "-czvf"))
    ("\\.ear$" ("zip" "-qr") ("zip" "-qr"))
;   ("\\.rar$" ("rar" "a")   ("rar" "a"))
    ("\\.war$" ("zip" "-qr") ("zip" "-qr"))
    ("\\.zip$" ("zip" "-qr") ("zip" "-qr"))
    ("\\.wmz$" ("zip" "-qr") ("zip" "-qr")) ;; for media player skins
    ("\\.arc$" ("arc" "a") nil)
    ("\\.zoo$" ("zoo" "aP") nil)
    ))

;; use pkzip with manipulating zip files (t) from within dired (use zip
;; and unzip otherwise)
(setq archive-zip-use-pkzip nil)

;; add these file types to archive mode to allow viewing and changing
;; their contents
(add-to-list 'auto-mode-alist '("\\.[ejrw]ar$\\'" . archive-mode))

;; modify the dired-extract switches to use the directory
;; ~/download/tryout as the default extract directory for zip files
(defconst MY_TRYOUT_DIR "~/downloads/tryout"
  "Directory for extracting files")

(setq dired-extract-alist
      `(
    ("\\.u\\(ue\\|aa\\)$" . dired-uud)
    ("\\.jar$" . "jar -xvf %s")
    ("\\.tar$" . ,(concat "tar -xf %s -C " MY_TRYOUT_DIR))
    ("\\.tgz$\\|\\.tar\\.g?[zZ]$" . ,(concat "tar -xzf %s -C " MY_TRYOUT_DIR))
    ("\\.arc$" . "arc x %s ")
    ("\\.bz2$" . ,(concat "bunzip2 -q %s"))
    ("\\.rar$" . ,(concat "unrar x %s " MY_TRYOUT_DIR "\\"))
    ("\\.zip$" . ,(concat "unzip -qq -Ux %s -d " MY_TRYOUT_DIR))
    ("\\.ear$" . ,(concat "unzip -qq -Ux %s -d " MY_TRYOUT_DIR))
    ("\\.war$" . ,(concat "unzip -qq -Ux %s -d " MY_TRYOUT_DIR))
    ("\\.zoo$" . "zoo x. %s ")
    ("\\.lzh$" . "lha x %s ")
    ("\\.7z$"  . "7z e %s ")
    ("\\.g?[zZ]$" . "gzip -d %s")   ; There is only one file
    ))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; dired_config.el ends here
