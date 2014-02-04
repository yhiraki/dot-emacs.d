;;; ido_config.el ---
;;
;; Filename: ido_config.el
;; Description:
;; Author: Manuel Schneckenreither
;; Maintainer:
;; Created: So Okt 13 23:25:02 2013 (+0200)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Mo Feb  3 19:54:01 2014 (+0100)
;;           By: Manuel Schneckenreither
;;     Update #: 16
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


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++ IDO COMPLETIONS ++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(require 'ido)
(ido-mode t)


;; DISPLAY IDO RESULTS VERTICALLY, RATHER THAN HORIZONTALLY
(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))

(defun ido-disable-line-truncation () (set (make-local-variable 'truncate-lines) nil))
(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)
(defun ido-define-keys () ;; C-n/p is more intuitive in vertical layout
  (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
  (define-key ido-completion-map (kbd "C-p") 'ido-prev-match))


(add-hook 'ido-setup-hook 'ido-define-keys)


;; LET IDO MODE COMPLETE ALMOST EVERYTHING
(defvar ido-enable-replace-completing-read t
      "If t, use ido-completing-read instead of completing-read if possible.

    Set it to nil using let in around-advice for functions where the
    original completing-read is required.  For example, if a function
    foo absolutely must use the original completing-read, define some
    advice like this:

    (defadvice foo (around original-completing-read-only activate)
      (let (ido-enable-replace-completing-read) ad-do-it))")

    ;; Replace completing-read wherever possible, unless directed otherwise
    (defadvice completing-read
      (around use-ido-when-possible activate)
      (if (or (not ido-enable-replace-completing-read) ; Manual override disable ido
              (and (boundp 'ido-cur-list)
                   ido-cur-list)) ; Avoid infinite loop from ido calling this
          ad-do-it
        (let ((allcomp (all-completions "" collection predicate)))
          (if allcomp
              (setq ad-return-value
                    (ido-completing-read prompt
                                   allcomp
                                   nil require-match initial-input hist def))
            ad-do-it))))

(add-hook 'ediff-hook
		  '(lambda ()
			 (set (make-local-variable 'ido-enable-replace-completing-read) nil)))
(add-hook 'dired-mode-hook
		  '(lambda ()
			 (set (make-local-variable 'ido-enable-replace-completing-read) nil)))


;; SORT IDO FILELIST BY MTIME INSTEAD OF ALPHABETICALLY
(add-hook 'ido-make-file-list-hook 'ido-sort-mtime)
(add-hook 'ido-make-dir-list-hook 'ido-sort-mtime)
(defun ido-sort-mtime ()
  (setq ido-temp-list
		(sort ido-temp-list
			  (lambda (a b)
				(time-less-p
				 (sixth (file-attributes (concat ido-current-directory b)))
				 (sixth (file-attributes (concat ido-current-directory a)))))))
  (ido-to-end  ;; move . files to end (again)
   (delq nil (mapcar
			  (lambda (x) (and (char-equal (string-to-char x) ?.) x))
			  ido-temp-list))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; ido_config.el ends here
