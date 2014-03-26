;;; emacs_lisp_config.el ---
;;
;; Filename: emacs_lisp_config.el
;; Description:
;; Author: Manuel Schneckenreither
;; Maintainer:
;; Created: So Okt 13 22:47:58 2013 (+0200)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Mo Mär 24 11:27:34 2014 (+0100)
;;           By: Manuel Schneckenreither
;;     Update #: 143
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
;; ++++++++++++++++++++++++++++ EMACS LISP  +++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; Create and set tags table
(defun make-emacs-lisp-tags ()
  "This function reloads the tags by using the command 'make tags'."
  (interactive)

  ;; only create tags if we are not in the home folder (otherwise it
  ;; does a find on all files in the home folder...and this takes
  ;; forever)
  (if (= 2 (length (split-string (expand-file-name default-directory)
                                 (concat load-emacsd))))
      (let ((dir (nth 0 (split-string default-directory load-emacsversion))))
        (setq esdir (replace-regexp-in-string " " "\\\\ " dir))
        (shell-command
         (concat "cd " esdir
                 " && find . -name '*.el' | etags - 1>/dev/null 2>/dev/null") nil)
        (visit-tags-table (concat dir "TAGS")))
    ))


;; MINOR MODE HOOK
(defun my/emacs-lisp-minor-mode ()
  "Minor mode hook for Emacs Lisp."

  ;; KEYS
  (local-set-key (kbd (concat prefix-command-key " e r")) 'eval-region)
  (local-set-key (kbd (concat prefix-command-key " e b")) 'eval-buffer)

  ;; AUTO COMPLETE MODE SOURCES
  (add-to-list 'ac-sources 'ac-source-features)
  (add-to-list 'ac-sources 'ac-source-functions)
  (add-to-list 'ac-sources 'ac-source-symbols)
  (add-to-list 'ac-sources 'ac-source-variables)
  (add-to-list 'ac-sources 'ac-source-dictionary)
  ;; (add-to-list 'ac-sources 'ac-source-etags)


  ;; (add-to-list 'ac-sources 'ac-source-abbrev)          ;; edited
  ;; (add-to-list 'ac-sources 'ac-source-css-property)
  ;; (add-to-list 'ac-sources 'ac-source-dictionary)
  ;; (add-to-list 'ac-sources 'ac-source-eclim)
  ;; (add-to-list 'ac-sources 'ac-source-yasnippet)
  ;; (add-to-list 'ac-sources 'ac-source-symbols)
  ;; (add-to-list 'ac-sources 'ac-source-filename)
  ;; (add-to-list 'ac-sources 'ac-source-files-in-current-dir)
  ;; (add-to-list 'ac-sources 'ac-source-gtags)
  ;; (add-to-list 'ac-sources 'ac-source-etags)
  ;; (add-to-list 'ac-sources 'ac-source-imenu)
  ;; (add-to-list 'ac-sources 'ac-source-semantic ;; slows down auto complete)
  ;; (add-to-list 'ac-sources 'ac-source-semantic-raw ;; slows down auto complete)
  ;; (add-to-list 'ac-sources 'ac-source-words-in-all-buffer)
  ;; (add-to-list 'ac-sources 'ac-source-words-in-buffer)
  ;; (add-to-list 'ac-sources 'ac-source-words-in-same-mode-buffers)

  ;; ensure auto-completion is started. If it doesn't work try to
  ;; disable flyspell mode.
  (auto-complete-mode)

  ;; use programming flyspell mode
  (flyspell-prog-mode)

  ;; CREATE AND SET TAGS FILE
  (add-hook 'after-save-hook 'make-emacs-lisp-tags)

)


(add-hook 'emacs-lisp-mode-hook 'my/emacs-lisp-minor-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; emacs_lisp_config.el ends here
