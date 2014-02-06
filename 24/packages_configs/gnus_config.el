;;; gnus_config.el ---
;;
;; Filename: gnus_config.el
;; Description:
;; Author: Manuel Schneckenreither
;; Maintainer:
;; Created: Di Feb  4 12:54:58 2014 (+0100)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Do Feb  6 11:38:00 2014 (+0100)
;;           By: Manuel Schneckenreither
;;     Update #: 87
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
;;; GNUS:


;; Don't create that ugly Mail folder in my home directory
;; (setq gnus-directory (expand-file-name "~/.mail/"))
;; (setq gnus-home-directory "~/.mail/")


(load-file (concat package-folder "gnus/gnus-desktop-notify.el"))

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++ QUITING GNUS ++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; first overwrite exit function, so gnus does not ask me if I really
;; want to quit
(defun gnus-group-exit ()
  "Quit reading news after updating .newsrc."
  (interactive)
  (progn
        (gnus-save-newsrc-file gnus-startup-file)
        (gnus-clear-system)
        (nntp-close-server)))

;; disable exiting with q
(defun local-gnus-group-mode ()
  ;; KEYS
  (local-set-key (kbd "q") (lambda ()
                             (interactive)
                             (error (substitute-command-keys (concat
                                     "disabled! Use C-x k to "
                                     "bury the buffer or "
                                     "\\[gnus-group-exit] to quit "
                                     "Gnus")))))
  (local-set-key (kbd "C-x k") (lambda ()
                                 (interactive)
                                 (bury-buffer)))
  (local-set-key (kbd "Q") 'gnus-group-exit))


;; set in group mode hook
(add-hook 'gnus-group-mode-hook 'local-gnus-group-mode)


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++++ GNUS CONFIG ++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; show old messages also
;; (setq gnus-fetch-old-headers t)

;; show all images, but the ones having "ads" in them.
;; (setq gnus-blocked-images "ads")
(setq gnus-blocked-images 'gnus-block-private-groups)

;; (setq gnus-html-cache-directory "~/.mail/.htmlcache")

;; CHANGE GNUS DIRECTORY TO NOT CLUTTER THE HOME DIRECTORY

;; archive
(setq gnus-message-archive-method
      '(nnfolder "archive"
                 (nnfolder-inhibit-expiry t)
                 (nnfolder-get-new-mail nil)
                 (nnfolder-active-file "~/.mail/sent-mail/active")
                 (nnfolder-directory "~/.mail/sent-mail/")
                 ))

(setq gnus-gcc-mark-as-read t)

;; drafts
(setq gnus-article-save-directory "~/.mail/News/")

(setq gnus-home-directory "~/.mail/")
(setq message-directory (concat gnus-home-directory "messages/"))
(setq nnfolder-directory (concat gnus-home-directory "archive/"))
(setq gnus-directory (concat gnus-home-directory "News/"))

;; for searching through imap folders (rest of config in .gnus)
(require 'nnir)


;; bbdb
(setq bbdb/news-auto-create-p t)

;; search imap
(setq nnir-imap-default-search-key "Imap")

(setq nnir-method-default-engines '((nnimap . imap)
                                    (nntp . gmane)
                                    ))

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++ Signature (on top) +++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(setq mail-signature t)
(setq mail-signature-file "~/.mail/signature")
(setq message-cite-reply-position (quote above))
(setq gnus-posting-styles '(
                            (".*"
                             (signature-file "~/.mail/signature")
                             (name "Manuel Schneckenreither"))
                            ))


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++ FINALLY OPEN GNUS +++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; open gnus
(gnus)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; gnus_config.el ends here
