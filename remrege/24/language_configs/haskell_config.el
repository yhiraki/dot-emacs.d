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
;;     Update #: 485
;; URL:
;; Description:
;;
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:

(require 'haskell-mode)

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


;; set DEBUG constant in haskell interpreter
;; (setq haskell-program-name "ghci -DDEBUG ")
(setq haskell-program-name "ghci -DDEBUG -fbreak-on-error")

(setq haskell-process-args-ghci (quote ("-ferror-spans -DDEBUG -fbreak-on-error")))


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++ USE INTERACTIVE MODE +++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; see http://haskell.github.io/haskell-mode/manual/latest/#haskell_002dinteractive_002dmode

;; (eval-after-load "haskell-mode"
;;   '(progn
;;     (define-key haskell-mode-map (kbd "C-x C-d") nil)
;;     (define-key haskell-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
;;     (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-file)
;;     (define-key haskell-mode-map (kbd "C-c C-b") 'haskell-interactive-switch)
;;     (define-key haskell-mode-map (kbd "C-c C-t") 'haskell-process-do-type)
;;     (define-key haskell-mode-map (kbd "C-c C-i") 'haskell-process-do-info)
;;     (define-key haskell-mode-map (kbd "C-c M-.") nil)
;;     (define-key haskell-mode-map (kbd "C-c C-d") nil)))


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++ OTHER FEATURES ++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


;;(eval-after-load "haskell-mode"
;;  (define-key haskell-mode-map (kbd "C-c v c") 'haskell-cabal-visit-file))


;;(eval-after-load "haskell-mode"
;;    '(define-key haskell-mode-map (kbd "C-x SPC") 'haskell-compile))

;;(eval-after-load "haskell-cabal"
;;    '(define-key haskell-cabal-mode-map (kbd "C-x SPC") 'haskell-compile))

;; (add-hook 'haskell-mode-hook 'turn-on-haskell-decl-scan)

;; (setq haskell-stylish-on-save t)

;; (eval-after-load "haskell-mode"
;;   '(progn
;;      (define-key haskell-mode-map (kbd "C-,") 'haskell-move-nested-left)
;;      (define-key haskell-mode-map (kbd "C-.") 'haskell-move-nested-right)))


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++++ FLYCHECK MODE ++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


;; (eval-after-load 'flycheck '(require 'flycheck-hdevtools))

;; (defun delete-hdevtools-socket-file ()
;;   "Delete the socket file for hdevtools."
;;   (interactive)
;;   (shell-command "rm -f .hdevtools.sock" nil)
;;   )

;; (add-hook 'open-file 'delete-hdevtools-socket-file)

;; enable flycheck
;; (eval-after-load 'flycheck '(require 'flycheck-hdevtools))

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
             " && hasktags -e . 2>/dev/null 1>/dev/null") nil)
    (visit-tags-table (concat dir "TAGS")))
  )

(defun haskell-source-code-align()
  "Format souce coude nicely."
  (interactive)
  (save-excursion
    ;; (haskell-mode-stylish-buffer)
    (push-mark (point))
    (push-mark (point-max) nil t)
    (goto-char (point-min))
    (haskell-indent-align-def t 'guard)
    (haskell-indent-align-def t 'rhs)
    ))

(defun haskell-insert-equals ()
  "Insert and aligns equals sign."
  (interactive)

  (if (not (s-contains? (char-to-string (char-before (point))) "=/><(|" ))
      (apply
       (haskell-indent-insert-equal)
       (delete-backward-char 1 nil))
    ;; (if (s-contains? (char-to-string (char-before (- (point) 1))) " " )
    ;;     (delete-backward-char 1 nil))
    (insert "=")
    ))

(defun haskell-insert-guard ()
  "Insert and aligns guard sign."
  (interactive)

  (if (not (s-contains? (char-to-string (char-before (point))) "|><=()" ))
      (apply
       (haskell-indent-insert-guard)
       (delete-backward-char 1 nil))
    ;; (if (s-contains? (char-to-string (char-before (- (point) 1))) " " )
    ;;     (delete-backward-char 1 nil))
    (insert "|")
    ))


(defun haskell-newline ()
  "Enter for haskell with ; at beginning."
  (interactive)
  (newline-and-indent)
  (insert "; ")
  )

;; MINOR MODE HOOK
(defun my/haskell-minor-mode ()
  "Minor mode hook for Haskell."

  ;; add auto-complete mode
  ;; (add-to-list 'ac-sources 'ac-source-abbrev)          ;; edited
  ;; (add-to-list 'ac-sources 'ac-source-css-property)
  ;; (add-to-list 'ac-sources 'ac-source-dictionary)
  ;; (add-to-list 'ac-sources 'ac-source-eclim)
  (add-to-list 'ac-sources 'ac-source-yasnippet)
  ;; (add-to-list 'ac-sources 'ac-source-symbols)
  ;; (add-to-list 'ac-sources 'ac-source-filename)
  ;; (add-to-list 'ac-sources 'ac-source-files-in-current-dir)
  ;; (add-to-list 'ac-sources 'ac-source-gtags)
  (add-to-list 'ac-sources 'ac-source-etags)
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

  ;; format source code in sensible way
  ;; (add-hook 'before-save-hook 'haskell-source-code-align nil t)

  ;; KEYS
  ;; fix return behaviour
  ;; (local-set-key (kbd "C-j")  'haskell-newline)
  (local-set-key (kbd "RET")  'newline-and-indent)
  ;; set special keys
  (local-set-key (kbd "=")  'haskell-insert-equals)
  ;; (local-set-key (kbd "|") 'haskell-insert-guard)

  (local-set-key (kbd "C-c =") (defun insertEquals ()
                                 (interactive)
                                 (insert "=")))

  ;; (local-set-key (kbd "C-c |") (defun insertGuard ()
  ;;                                (interactive)
  ;;                                (insert "|")))


  ;; CREATE AND SET TAGS FILE
  (add-hook 'after-save-hook 'make-haskell-tags nil t)
  )


(add-hook 'haskell-mode-hook 'my/haskell-minor-mode)
(add-hook 'haskell-mode-hook 'highlight-keywords)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; haskell_config.el ends here


