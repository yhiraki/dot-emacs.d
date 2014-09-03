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
;;     Update #: 642
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
        "-pgmF loch"
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
  (add-to-list 'ac-sources 'ac-source-words-in-buffer)
  ;; (add-to-list 'ac-sources 'ac-source-words-in-same-mode-buffers)

  (auto-complete-mode)

  ;; use programming flyspell mode
  (flyspell-prog-mode)

  ;; format source code in sensible way
  ;; (add-hook 'before-save-hook 'haskell-source-code-align nil t)

  ;; KEYS
  ;; fix return behavior
  ;; (define-key 'haskell-mode-map (kbd "C .") 'find-tag)
  ;; (define-key interactive-haskell-mode-map (kbd "C-c c") nil)

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

  ;; (local-set-key (kbd "M-.") 'find-tag)
  ;; (local-unset-key (kbd "C-c c"))
  ;; (local-unset-key (kbd "C-."))
  ;; (local-unset-key (kbd "M-."))

  ;; why would the use the interactive-haskell-mode-map for .hs files???
  (define-key interactive-haskell-mode-map (kbd "C-c c") nil)
  (define-key interactive-haskell-mode-map (kbd "C-.") nil)
  (define-key interactive-haskell-mode-map (kbd "M-.") nil)
  (define-key haskell-mode-map (kbd "M-.") nil)

  ;; (define-set-key (kbd "C-.") 'view-tag-other-window)
  ;; (define-set-key (kbd "M-.") 'find-tag)
  ;; (define-set-key (kbd "C-c c") 'comment-or-uncomment-region)
  ;; (define-key 'haskell-mode-map (kbd "C-.") 'find-tag)


  ;; CREATE AND SET TAGS FILE
  (add-hook 'after-save-hook 'make-haskell-tags nil t)
  ;; (add-hook 'after-save-hook (lambda ()
  ;;                              (let ((buffer (get-buffer "*Warnings*")))
  ;;                                (if (boundp 'buffer)
  ;;                                    (bury-buffer buffer)
  ;;                                 ))))
  )

;; (eval-after-load "haskell-mode"
;;   '(progn
;;      (define-key haskell-mode-map (kbd "M-.") 'find-tag)))


;; MINOR INFERIOR MODE HOOK
(defun my/haskell-interactive-minor-mode ()
  "Minor mode hook for Haskell."

  ;; add auto-complete mode
  (add-to-list 'ac-sources 'ac-source-abbrev)          ;; edited
  ;; (add-to-list 'ac-sources 'ac-source-css-property)
  (add-to-list 'ac-sources 'ac-source-dictionary)
  ;; (add-to-list 'ac-sources 'ac-source-eclim)
  ;; (add-to-list 'ac-sources 'ac-source-yasnippet)
  ;; (add-to-list 'ac-sources 'ac-source-symbols)
  (add-to-list 'ac-sources 'ac-source-filename)
  ;; (add-to-list 'ac-sources 'ac-source-files-in-current-dir)
  ;; (add-to-list 'ac-sources 'ac-source-gtags)
  (add-to-list 'ac-sources 'ac-source-etags)
  (add-to-list 'ac-sources 'ac-source-imenu) ;; broken !!!
  ;; (add-to-list 'ac-sources 'ac-source-semantic) ;; slows down auto complete)
  ;; (add-to-list 'ac-sources 'ac-source-semantic-raw ;; slows down auto complete)
  ;; (add-to-list 'ac-sources 'ac-source-words-in-all-buffer)
  (add-to-list 'ac-sources 'ac-source-words-in-buffer)
  (add-to-list 'ac-sources 'ac-source-words-in-same-mode-buffers)

  (auto-complete-mode)

  )


(add-hook 'haskell-mode-hook 'my/haskell-minor-mode)
(add-hook 'haskell-interactive-mode-hook 'my/haskell-interactive-minor-mode)
;;(add-hook 'haskell-mode-hook 'highlight-keywords)


;; IDENTATION MODE
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)

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

;; disable popusv
(setq haskell-interactive-popup-errors nil)

;; modules to add
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-decl-scan-mode)
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-unicode-input-method)
(setq haskell-font-lock-symbols t)


;; OVERWRITE FUNCTIONS TO CHANGE BEHAVIOR

(defun haskell-mode-buffer-apply-command (cmd)
  "Execute shell command CMD with current buffer as input and
replace the whole buffer with the output. If CMD fails the buffer
remains unchanged."
  (set-buffer-modified-p t)
  (let* ((chomp (lambda (str)
                  (while (string-match "\\`\n+\\|^\\s-+\\|\\s-+$\\|\n+\\'" str)
                    (setq str (replace-match "" t t str)))
                  str))
         (errout (lambda (fmt &rest args)
                   (let* ((warning-fill-prefix " "))
                     (display-warning cmd (apply 'format fmt args) :warning))))
         (filename (buffer-file-name (current-buffer)))
         (cmd-prefix (replace-regexp-in-string " .*" "" cmd))
         (tmp-file (make-temp-file cmd-prefix))
         (err-file (make-temp-file cmd-prefix))
         (default-directory (if (and (boundp 'haskell-session)
                                     haskell-session)
                                (haskell-session-cabal-dir haskell-session)
                              default-directory))
         (errcode (with-temp-file tmp-file
                    (call-process cmd filename
                                  (list (current-buffer) err-file) nil)))
         (stderr-output ""
          ;; (with-temp-buffer
          ;;   (insert-file-contents err-file)
          ;;   (funcall chomp (buffer-substring-no-properties (point-min) (point-max))))
          )
         (stdout-output
          (with-temp-buffer
            (insert-file-contents tmp-file)
            (buffer-substring-no-properties (point-min) (point-max)))))
    (if (string= "" stderr-output)
        (if (string= "" stdout-output)
            (funcall errout
                     "Error: %s produced no output, leaving buffer alone" cmd)
          (save-restriction
            (widen)
            ;; command successful, insert file with replacement to preserve
            ;; markers.
            (insert-file-contents tmp-file nil nil nil t)))
      ;; non-null stderr, command must have failed
      (funcall errout "%s failed: %s" cmd stderr-output)
      )
    (delete-file tmp-file)
    (delete-file err-file)
    ))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; haskell_config.el ends here
