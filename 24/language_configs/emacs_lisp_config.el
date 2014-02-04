;;; emacs_lisp_config.el ---
;;
;; Filename: emacs_lisp_config.el
;; Description:
;; Author: Manuel Schneckenreither
;; Maintainer:
;; Created: So Okt 13 22:47:58 2013 (+0200)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Di Feb  4 13:37:08 2014 (+0100)
;;           By: Manuel Schneckenreither
;;     Update #: 89
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

  ;; only create tags if we are not in the home folder
  (if (> 1 (length (split-string default-directory home-folder)))

      (let ((dir (nth 0 (split-string default-directory load-emacsversion))))
        (setq esdir (replace-regexp-in-string " " "\\\\ " dir))
        (shell-command
         (concat "cd " esdir
                 " && find . -name '*.el' -print | etags - 1>/dev/null 2>/dev/null") nil)
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
  ;; (add-to-list 'ac-sources 'ac-source-etags)
  ;; CREATE AND SET TAGS FILE --- disabled for el files
  (add-hook 'after-save-hook 'make-emacs-lisp-tags nil t)
)

(add-hook 'emacs-lisp-mode-hook 'my/emacs-lisp-minor-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; emacs_lisp_config.el ends here
