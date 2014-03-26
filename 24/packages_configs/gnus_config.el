;;; gnus_config.el ---
;;
;; Filename: gnus_config.el
;; Description:
;; Author: Manuel Schneckenreither
;; Maintainer:
;; Created: Di Feb  4 12:54:58 2014 (+0100)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Mo Mär 24 13:15:46 2014 (+0100)
;;           By: Manuel Schneckenreither
;;     Update #: 145
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

(setq gnus-asynchronous t)
(setq gnus-use-cache t)

;; show all images, but the ones having "ads" in them.
;; (setq gnus-blocked-images "ads")
(setq gnus-blocked-images 'gnus-block-private-groups)


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
(setq gnus-directory (concat gnus-home-directory "news/"))
(setq gnus-kill-files-directory (concat gnus-home-directory "score/"))
(setq gnus-cache-directory (concat gnus-home-directory ".cache/"))
(setq gnus-html-cache-directory (concat gnus-home-directory "htmlcache/"))

;; for searching through imap folders (rest of config in .gnus)
(require 'nnir)


;; bbdb
(setq bbdb/news-auto-create-p t)

;; search imap
(setq nnir-imap-default-search-key "Imap")

(setq nnir-method-default-engines '((nnimap . imap)
                                    (nntp . gmane)
                                    ))


;; set custom timeout
(defadvice gnus-demon-scan-news (around gnus-demon-timeout activate)
  "Timeout for Gnus."
  (with-timeout
      (15 (message "Gnus timed out."))
    ad-do-it))


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++++ SIGNATURE ++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(setq mail-signature t)
(setq mail-signature-file "~/.mail/signature")
(setq message-cite-reply-position (quote traditional))
(setq gnus-posting-styles '(
                            (".*"
                             (signature-file "~/.mail/signature")
                             (name "Manuel Schneckenreither"))
                            ))

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++ SCORES ++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(setq gnus-use-adaptive-scoring '(word line))


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++ SENT MESSAGE FOLDERS +++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


;; Automatically put the sent messages in the input folder. This
;; enables a nice history view of the topics.

(setq gnus-message-archive-method '(nnml ""))

(setq gnus-message-archive-group
      '((lambda (x)
          (cond
           ;; Store personal mail messages in the same group I started
           ;; out in
           ((string-match "mail.*" group) group)
           ;; I receive a copy of all messages I send to a list, so
           ;; there's no need to archive
           ((string-match "list.*" group) nil)
           ;; Store everything else in misc until I can sort it out
           (t "mail.misc")))))

;; edit score for replying
(add-hook 'message-sent-hook 'gnus-score-followup-thread)


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++++++ CITING +++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; use the built in supercite for citing.
(add-hook 'mail-citation-hook 'sc-cite-original)

;; This prevents GNUS from inserting its default attribution header.
;; Otherwise, both GNUS and Supercite will insert an attribution
;; header:
(setq news-reply-header-hook nil)

(setq mail-user-agent 'gnus-user-agent)

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++ SIGNING MESSAGES ++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; Always sign encrypted messages
(setq mc-pgp-always-sign t)
;; How long should mailcrypt remember your passphrase
(setq mc-passwd-timeout 600)

;; Automagically sign all messages
(add-hook 'message-send-hook 'will-you-sign)
(defun will-you-sign ()
  (interactive)
  (if (y-or-n-p "Do you want to sign this message? ")
      (mml-secure-sign-pgp)))


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++ FORMATING LISTS ++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


;; article lists
(setq-default
 gnus-summary-line-format "%U%R%z %(%&user-date;  %-15,15f  %B%s%)\n"
 gnus-user-date-format-alist '((t . "%d.%m.%Y %H:%M"))
 gnus-summary-thread-gathering-function 'gnus-gather-threads-by-references
 gnus-thread-sort-functions '(gnus-thread-sort-by-date)
 gnus-sum-thread-tree-false-root ""
 gnus-sum-thread-tree-indent " "
 gnus-sum-thread-tree-leaf-with-other "├► "
 gnus-sum-thread-tree-root ""
 gnus-sum-thread-tree-single-leaf "╰► "
 gnus-sum-thread-tree-vertical "│")


;; Coloring empty topics differently from non-empty topics is a nice idea.
(setq gnus-topic-line-format "%i[ %u&topic-line; ] %v\n")

;; this corresponds to a topic line format of "%n %A"
(defun gnus-user-format-function-topic-line (dummy)
  (let ((topic-face (if (zerop total-number-of-articles)
                        'my-gnus-topic-empty-face
                      'my-gnus-topic-face)))
    (propertize
     (format "%s %d" name total-number-of-articles)
     'face topic-face)))


;; Replacing common prefixes of group names with spaces
;; (defvar gnus-user-format-function-g-prev "" "")
;; (defun empty-common-prefix (left right)
;;   "Given `left' '(\"foo\" \"bar\" \"fie\") and `right' '(\"foo\"
;;     \"bar\" \"fum\"), return '(\"   \" \"   \" \"fum\")."
;;   (if (and (cdr right)			; always keep the last part of right
;;            (equal (car left) (car right)))
;;       (cons (make-string (length (car left)) ? )
;;             (empty-common-prefix (cdr left) (cdr right)))
;;     right))
;; (defun gnus-user-format-function-g (arg)
;;   "The full group name, but if it starts with a previously seen
;;     prefix, empty that prefix."
;;   (if (equal gnus-user-format-function-g-prev gnus-tmp-group) ; line-format is updated on exiting the summary, making prev equal this
;;       gnus-tmp-group
;;     (let* ((prev (split-string-and-unquote gnus-user-format-function-g-prev "\\."))
;;            (this (split-string-and-unquote gnus-tmp-group "\\.")))
;;       (setq gnus-user-format-function-g-prev gnus-tmp-group)
;;       (combine-and-quote-strings
;;        (empty-common-prefix prev this)
;;        "."))))
;; (setq gnus-group-line-format "%M%S%p%P%5y:%B%(%ug%)\n")

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++ FINALLY OPEN GNUS +++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; do not download everyting when gnus starts
(setq gnus-read-active-file 'some)


;; set timeout so we don't get stuck
(setq nntp-connection-timeout 3)

;; open gnus
(gnus)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; gnus_config.el ends here
