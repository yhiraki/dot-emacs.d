;;; elm_config.el ---
;;
;; Filename: elm_config.el
;; Description:
;; Author: Manuel Schneckenreither
;; Maintainer:
;; Created: Mon Dec 11 18:43:40 2017 (+0100)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Sat Dec 30 11:06:05 2017 (+0100)
;;           By: Manuel Schneckenreither
;;     Update #: 20
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
                 " && find . -name '*.elm' | "
                 "etags --language=none --regex=@ - 1>/dev/null 2>/dev/null") nil)
    (visit-tags-table (concat dir "TAGS")))
  )

;; MINOR MODE HOOK
(defun my/elm-minor-mode ()
  "Minor mode hook for Elm."

  ;; CREATE AND SET TAGS FILE
  (add-hook 'after-save-hook 'make-elm-tags nil t)
  (local-set-key (kbd "RET")  'newline-and-indent)
  ;; (hare-init)
  )


(add-hook 'elm-mode-hook 'my/elm-minor-mode)
(add-hook 'elm-mode-hook 'haskell-indentation-mode)

(setq elm-format-on-save t)
(require 'flycheck)
;; ;; (with-eval-after-load 'flycheck
;; ;;       '(add-hook 'flycheck-mode-hook #'flycheck-elm-setup))
;; (add-hook 'after-init-hook #'global-flycheck-mode)

;; ;; autocompletion
;; (require 'company)
;; (add-to-list 'company-backends 'company-elm)


(require 'elm-mode)

(add-hook 'flycheck-mode-hook 'flycheck-elm-setup)
(add-hook 'elm-mode-hook
          (lambda ()
            (setq company-backends '(company-elm))))
;            (set (make-local-variable 'company-backends) '(company-elm))))

(add-hook 'elm-mode-hook #'elm-oracle-setup-completion)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; elm_config.el ends here
