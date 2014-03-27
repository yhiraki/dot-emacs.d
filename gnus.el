;;; gnus.el ---
;;
;; Filename: gnus.el
;; Description:
;; Author: Manuel Schneckenreither
;; Maintainer:
;; Created: Di Feb  4 17:01:05 2014 (+0100)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Mi Mär 26 15:45:25 2014 (+0100)
;;           By: Manuel Schneckenreither
;;     Update #: 27
;; URL:
;; Doc URL:
;; Keywords:
;; Compatibility:
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;;  This file gets loaded by the file ~/.gnus.el on each Gnus startup.
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


;; for searching imap folders (needs the call of (require 'nnir) in .emacs)

;; other newsfeeds
(setq gnus-select-method '(nnimap "uibk"
                                  (nnimap-stream ssl)
                                  (nnimap-server-port 993)
                                  (nnimap-address "mail2.uibk.ac.at")
                                  ;(nnir-search-engine Imap)
                                  ;; if a connection to an IMAP server
                                  ;; can't be closed, force close
                                  ;; after 1s
                                  (nnimap-logout-timeout 1.0)
                                  ))

(add-to-list 'gnus-secondary-select-methods '(nnimap "gmail"
                                                     (nnimap-stream ssl)
                                                     (nnimap-address "imap.gmail.com")
                                                     (nnimap-server-port 993)
                                                     ;;(nnir-search-engine Imap)
                                                     (nnimap-logout-timeout 1.0)
                                                     ))


;; Periodically check for mail/news
(gnus-demon-init)
(gnus-demon-add-handler 'gnus-demon-scan-news 5 t)


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++++ GNUS NOTIFY ++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(require 'gnus-desktop-notify)
(gnus-desktop-notify-mode)
(gnus-demon-add-scanmail)


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++ SPLITTING MAIL +++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; 6.4.3 Splitting Mail
;; --------------------

;; The ‘nnmail-split-methods’ variable says how the incoming mail is to be
;; split into groups.

;;      (setq nnmail-split-methods
;;        '(("mail.junk" "^From:.*Lars Ingebrigtsen")
;;          ("mail.crazy" "^Subject:.*die\\|^Organization:.*flabby")
;;          ("mail.other" "")))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; gnus.el ends here
