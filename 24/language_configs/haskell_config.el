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
;;     Update #: 582
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


;; IDENTATION MODE
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)


;; INTERACTION MODES
;; (add-hook 'haskell-mode-hook 'inf-haskell-mode) ; deprecated !!!
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)


;; OTHER MODES
(add-hook 'haskell-mode-hook 'haskell-decl-scan-mode) ; Scans top-level
                                                      ; declarations, and places
                                                      ; them in a menu.

(add-hook 'haskell-mode-hook 'haskell-doc-mode) ; Echoes types of functions or
                                                ; syntax of keywords when the
                                                ; cursor is idle.


;; modules to add
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-decl-scan-mode)
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-unicode-input-method)
(setq haskell-font-lock-symbols t)


;; disable popus
(setq haskell-interactive-popup-errors nil)

;; (eval-after-load "which-func"
;;   '(add-to-list 'which-func-modes 'haskell-mode))

;; (autoload 'haskell-refac-mode "haskell-refac"
;;   "Minor mode for refactoring Haskell programs" t)
;; (add-hook 'haskell-mode-hook 'turn-on-font-lock)
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;; (remove-hook 'haskell-mode-hook 'turn-on-haskell-ghci)
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
;; (add-hook 'haskell-mode-hook 'haskell-refac-mode)
;; (add-hook 'haskell-mode-hook 'hs-lint-mode-hook)

;; set DEBUG constant in haskell interpreter
;; (setq haskell-program-name "ghci -DDEBUG ")
(setq haskell-program-name "ghci")
(setq haskell-process-args-ghci
      '("-ferror-spans"
        "-DDEBUG"
        "-fbreak-on-error"
        "-fllvm"
        "-fasm"))

;; (define-key haskell-mode-map (kbd "C-x C-s") 'haskell-mode-save-buffer)
(setq haskell-stylish-on-save t)

;; (speedbar-add-supported-extension ".hs")

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++ HADDOCK ++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; (require 'w3m-haddock)
;; (add-hook 'w3m-display-hook 'w3m-haddock-display)

;; (define-key haskell-mode-map (kbd "C-c C-d") 'haskell-w3m-open-haddock)

;; (setq w3m-mode-map (make-sparse-keymap))

;; (define-key w3m-mode-map (kbd "RET") 'w3m-view-this-url)
;; (define-key w3m-mode-map (kbd "q") 'bury-buffer)
;; (define-key w3m-mode-map (kbd "<mouse-1>") 'w3m-maybe-url)
;; (define-key w3m-mode-map [f5] 'w3m-reload-this-page)
;; (define-key w3m-mode-map (kbd "C-c C-d") 'haskell-w3m-open-haddock)
;; (define-key w3m-mode-map (kbd "M-<left>") 'w3m-view-previous-page)
;; (define-key w3m-mode-map (kbd "M-<right>") 'w3m-view-next-page)
;; (define-key w3m-mode-map (kbd "M-.") 'w3m-haddock-find-tag)

;; (defun w3m-maybe-url ()
;;   (interactive)
;;   (if (or (equal '(w3m-anchor) (get-text-property (point) 'face))
;;           (equal '(w3m-arrived-anchor) (get-text-property (point) 'face)))
;;       (w3m-view-this-url)))

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


;; need to declare these two function
;; they do not seem to be imported with s
(defun s--truthy? (val)
  (not (null val)))
(defun s-contains? (needle s &optional ignore-case)
  "Does S contain NEEDLE?
If IGNORE-CASE is non-nil, the comparison is done without paying
attention to case differences."
  (let ((case-fold-search ignore-case))
    (s--truthy? (string-match-p (regexp-quote needle) s))))

(defun haskell-insert-equals ()
  "Insert and aligns equals sign."
  (interactive)

  (if (not (s-contains? (char-to-string (char-before (point))) "=/><(|" ))
      (progn
       (haskell-indent-insert-equal)
       (delete-backward-char 1 nil))
    ;; (if (s-contains? (char-to-string (char-before (- (point) 1))) " " )
    ;;     (delete-backward-char 1 nil))
    (insert "=")
    )
  )

(defun haskell-insert-guard ()
  "Insert and aligns guard sign."
  (interactive)

  (if (not (s-contains? (char-to-string (char-before (point))) "|><=()" ))
      (progn
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
  (add-to-list 'ac-sources 'ac-source-abbrev)          ;; edited
  ;; (add-to-list 'ac-sources 'ac-source-css-property)
  (add-to-list 'ac-sources 'ac-source-dictionary)
  ;; (add-to-list 'ac-sources 'ac-source-eclim)
  (add-to-list 'ac-sources 'ac-source-yasnippet)
  ;; (add-to-list 'ac-sources 'ac-source-symbols)
  ;; (add-to-list 'ac-sources 'ac-source-filename)
  ;; (add-to-list 'ac-sources 'ac-source-files-in-current-dir)
  ;; (add-to-list 'ac-sources 'ac-source-gtags)
  (add-to-list 'ac-sources 'ac-source-etags)
  (add-to-list 'ac-sources 'ac-source-imenu) ;; broken !!!
  ;; (add-to-list 'ac-sources 'ac-source-semantic) ;; slows down auto complete)
  ;; (add-to-list 'ac-sources 'ac-source-semantic-raw ;; slows down auto complete)
  ;; (add-to-list 'ac-sources 'ac-source-words-in-all-buffer)
  ;; (add-to-list 'ac-sources 'ac-source-words-in-buffer)
  ;; (add-to-list 'ac-sources 'ac-source-words-in-same-mode-buffers)

  (auto-complete-mode)

  ;; use programming flyspell mode
  (flyspell-prog-mode)

  ;; format source code in sensible way
  ;; (add-hook 'before-save-hook 'haskell-source-code-align nil t)

  ;; KEYS
  ;; fix return behavior
  (define-key interactive-haskell-mode-map (kbd "C-c c") nil)

  ;; (Local-set-key (kbd "C-j")  'haskell-newline)
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

  (local-set-key (kbd "C-c i") 'haskell-mode-jump-to-def-or-tag)

  ;; CREATE AND SET TAGS FILE
  (add-hook 'after-save-hook 'make-haskell-tags nil t)
  )


(add-hook 'haskell-mode-hook 'my/haskell-minor-mode)
;;(add-hook 'haskell-mode-hook 'highlight-keywords)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; haskell_config.el ends here
