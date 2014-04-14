;;; bmkp_config.el ---
;;
;; Filename: bmkp_config.el
;; Description:
;; Author: Manuel Schneckenreither
;; Maintainer:
;; Created: Mi Mär 19 14:51:22 2014 (+0100)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Do Apr 10 14:58:33 2014 (+0200)
;;           By: Manuel Schneckenreither
;;     Update #: 72
;; URL:
;; Doc URL:
;; Keywords:
;; Compatibility:
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;;
;; I want Emacs to start up clean (without loading any desktop
;; file) and then select the project which I like working on using
;; the Bookmark+ extension.  Therefore, I need ‘desktop-save-mode’ to
;; ‘nil’.  That means desktops do not get saved,  no matter if I load
;; any with Bookmark+.  The variable ‘desktop-save’ (which is set to
;; ‘ask-if-new‘ in my configuration) will be ignored also.  That means
;; if I’d like to save the latest state of my desktop (before
;; switching to another desktop file using Bookmark+ or closing Emacs)
;; I need to do that manually.  This little library does exactly this.
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


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++ BOOKMARK PLUS ++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(require 'bookmark+)
(require 'desktop)


;; the original jump desktop
;; added the automatic saving of the desktop bookmark file before switching
(defun schnecki-jump-desktop (bookmark)
  "Jump to desktop bookmark BOOKMARK.
Handler function for record returned by `bmkp-make-desktop-record'.
BOOKMARK is a bookmark name or a bookmark record."
  (let ((desktop-file  (bookmark-prop-get bookmark 'desktop-file)))
    (if current-desktop-file
        (my-save-desktop current-desktop-file nil nil))
    (setq current-desktop-file (bookmark-prop-get bookmark 'desktop-file))

    (unless (condition-case nil (require 'desktop nil t) (error nil))
      (error "You must have library `desktop.el' to use this command"))
    ;; (unless desktop-file (error "Not a desktop-bookmark: %S" bookmark)) ; Shouldn't happen.
    (bmkp-desktop-change-dir desktop-file)

    (unless (bmkp-desktop-read desktop-file) (error "Could not load desktop file"))
    (message (concat "Current-desktop-file: " (bookmark-prop-get bookmark 'desktop-file)))))


;; THIS FUNCTION OVERWRITES THE ORIGINAL BMKP-JUMP-DESKTOP FUNCTION
;;
;; function that check for gnus and the calls jump desktop, afterwards
;; open gnus again
(defun bmkp-jump-desktop (bookmark)
  "Check if Gnus is open. If so, close it, load bookmark, then
reopen it."
  (let (buf)
    ;; preset the current desktop file
    (if (not (boundp 'current-desktop-file))
        (setq current-desktop-file nil))
    (let ((gnusAlive (and (fboundp 'gnus-alive-p)
                          (gnus-alive-p)
                          (bufferp (setq buf (get-buffer "*Group*"))))))
      (when gnusAlive
        (gnus-group-exit))
      (schnecki-jump-desktop bookmark)
      (when gnusAlive
        (gnus)                          ; open gnus
        (schnecki-gnus)                 ; hide gnus
        ))))


;; save desktop before quitting emacs (in case one was loaded)
(add-hook 'kill-emacs-hook (lambda ()
                             (if (not (boundp 'current-desktop-file))
                                 (setq current-desktop-file nil))
                             (if current-desktop-file
                                 (my-save-desktop current-desktop-file nil nil))
                             ))

;; this function automatically saves the bookmark file. it was copied
;; from the original save-desktop function and then modified.
(defun my-save-desktop (filepath release auto-save)
  (interactive)
  (save-excursion
    (let ((eager nil ))

      (with-temp-buffer
        (insert
         ";; -*- mode: emacs-lisp; coding: emacs-mule; -*-\n"
         desktop-header
         ";; Created " (current-time-string) "\n"
         ";; Desktop file format version " desktop-file-version "\n"
         ";; Emacs version " emacs-version "\n")
        (save-excursion (run-hooks 'desktop-save-hook))
        (goto-char (point-max))
        (insert "\n;; Global section:\n")
        ;; Called here because we save the window/frame state as a global
        ;; variable for compatibility with previous Emacsen.
        ;; (desktop-save-frameset)
        (unless (memq 'desktop-saved-frameset desktop-globals-to-save)
          (desktop-outvar 'desktop-saved-frameset))
        (mapc (function desktop-outvar) desktop-globals-to-save)
        (setq desktop-saved-frameset nil) ; after saving desktop-globals-to-save
        (when (memq 'kill-ring desktop-globals-to-save)
          (insert
           "(setq kill-ring-yank-pointer (nthcdr "
           (int-to-string (- (length kill-ring) (length kill-ring-yank-pointer)))
           " kill-ring))\n"))

        (insert "\n;; Buffer section -- buffers listed in same order as in buffer list:\n")
        (dolist (l (mapcar 'desktop-buffer-info (buffer-list)))
          (let ((base (pop l)))
            (when (apply 'desktop-save-buffer-p l)
              (insert "("
                      (if (or (not (integerp eager))
                              (if (zerop eager)
                                  nil
                                (setq eager (1- eager))))
                          "desktop-create-buffer"
                        "desktop-append-buffer-args")
                      " "
                      desktop-file-version)
              ;; If there's a non-empty base name, we save it instead of the buffer name
              ;; (when (and base (not (string= base "")))
              (setcar (nthcdr 1 l) base)
              ;; )
              (dolist (e l)
                (insert "\n  " (desktop-value-to-string e)))
              (insert ")\n\n"))))
        (write-region (point-min) (point-max) filepath nil 'nomessage)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; bmkp_config.el ends here
