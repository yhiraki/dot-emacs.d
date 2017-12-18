;;; elm_config.el ---
;;
;; Filename: elm_config.el
;; Description:
;; Author: Manuel Schneckenreither
;; Maintainer:
;; Created: Mon Dec 11 18:43:40 2017 (+0100)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Mon Dec 11 21:46:13 2017 (+0100)
;;           By: Manuel Schneckenreither
;;     Update #: 10
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
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:

(require 'elm-mode)

;; Create and set tags table
(defun make-elm-tags ()
  "This function reloads the tags by using the command 'make tags'."
  (interactive)
  (let ((dir (nth 0 (if (string-match "app/" default-directory)
                        (split-string default-directory "app")
                      (split-string default-directory "src")))))
    (setq esdir (replace-regexp-in-string " " "\\\\ " dir))
            (shell-command
         (concat "cd " esdir
                 " && find . -name '*.elm' | etags - 1>/dev/null 2>/dev/null") nil)
    (visit-tags-table (concat dir "TAGS")))
  )

;; MINOR MODE HOOK
(defun my/elm-minor-mode ()
  "Minor mode hook for Elm."

  ;; CREATE AND SET TAGS FILE
  (add-hook 'after-save-hook 'make-elm-tags nil t)
  ;; (hare-init)
  )


(add-hook 'elm-mode-hook 'my/elm-minor-mode)


(setq elm-format-on-save t)
(require 'flycheck)
(with-eval-after-load 'flycheck
      '(add-hook 'flycheck-mode-hook #'flycheck-elm-setup))


;; autocompletion
(require 'company)
(add-to-list 'company-backends 'company-elm)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; elm_config.el ends here
