;;; package -- haskell_config.el ---
;;; Commentary:
;;
;; Filename: haskell_config.el
;; Status:
;; Author: Manuel Schneckenreither
;; Created: Mo Sep  2 22:31:57 2013 (+0200)
;; Version:
;; Last-Updated:
;;           By:
;;     Update #: 165
;; URL:
;; Description:
;;
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++++ HASKELL CONFIGS ++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


;; (autoload 'haskell-refac-mode "haskell-refac"
;;   "Minor mode for refactoring Haskell programs" t)
;; (add-hook 'haskell-mode-hook 'turn-on-font-lock)
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-ghci)
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
;; (add-hook 'haskell-mode-hook 'haskell-refac-mode)
;; (add-hook 'haskell-mode-hook 'hs-lint-mode-hook)

;; modules to add
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-decl-scan-mode)

;; identation mode
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)

;; [==:INIT ghc-mod==]
;; (autoload 'ghc-init "ghc" nil t)
;; (add-hook 'haskell-mode-hook
;;           (lambda ()
;;             (ghc-init)))

;; [==:INIT auto-complete==]
(ac-define-source ghc-mod
  '((depends ghc)
    (candidates . (ghc-select-completion-symbol))
    (symbol . "s")
    (cache)))

;; ;; [==:INIT fnd-file-hook==]
;; (defun my-haskell-ac-init ()
;;   (when (member (file-name-extension buffer-file-name) '("hs" "lhs"))

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++++++ MINOR MODE +++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; Create and set tags table
(defun make-haskell-tags ()
  "This function reloads the tags by using the command 'make tags'."
  (interactive)
  (let ((dir (nth 0 (split-string default-directory "src"))))
    (setq esdir (replace-regexp-in-string " " "\\\\ " dir))
    (shell-command
     (concat "cd " esdir
             " && find . -name \"*.hs\" -print | etags - 2>/dev/null 1>/dev/null") t)
    (visit-tags-table (concat dir "TAGS")))
  )

(defun haskell-source-code-align()
  "Format souce coude nicely."
  (interactive)
  (save-excursion
      (push-mark (point))
      (push-mark (point-max) nil t)
      (goto-char (point-min))
      (haskell-indent-align-def t 'guard)
      (haskell-indent-align-def t 'rhs)
  ))


;; MINOR MODE HOOK
(defun my/haskell-minor-mode ()
  "Minor mode hook for Haskell."

  ;; add auto-complete mode
  (add-to-list 'ac-sources 'ac-source-ghc-mod)
  (add-to-list 'ac-sources 'ac-source-etags)

  ;; format source code in sensible way
  ;; (add-hook 'before-save-hook 'haskell-source-code-align nil t)

  ;; KEYS
  ;; fix return behaviour
  (local-set-key (kbd "RET")  'newline-and-indent)
  ;; set special keys
  (local-set-key (kbd "=") 'haskell-indent-insert-equal)
  (local-set-key (kbd "|") 'haskell-indent-insert-guard)

  ;; CREATE AND SET TAGS FILE
  (add-hook 'after-save-hook 'make-haskell-tags nil t)
  )


(add-hook 'haskell-mode-hook 'my/haskell-minor-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; haskell_config.el ends here
