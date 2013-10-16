;;; keybindings_hooks.el ---
;;
;; Filename: keybindings_hooks.el
;; Status:
;; Author: Manuel Schneckenreither
;; Created: So Sep 29 14:21:26 2013 (+0200)
;; Version:
;; Last-Updated:
;;           By:
;;     Update #: 40
;; URL:
;; Description:
;;
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:


;;; package -- Summary
;;; Commentary:

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++++ DEFAULT KEYS +++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;;            in my eyes these keys should work out of the box


;; fix identation for splitting lines
(global-set-key (kbd "RET") 'reindent-then-newline-and-indent)
(global-set-key [C-tab] 'bs-cycle-next) ;; next buffer
(global-set-key [C-S-iso-lefttab] 'bs-cycle-previous) ;; previous buffer
(global-set-key (kbd "C-x C-b") 'ibuffer)  ;; ibuffer
(global-set-key [f11] 'my-toggle-fullscreen) ;; defined in basics.el

;; self-made function to insert a couple of charactes around the region
;; (global-set-key (kbd "C-c \"")  'insert-apostrophes)
;; (global-set-key (kbd "C-c (")  'insert-parenthesis)
;; (global-set-key (kbd "C-c )")  'insert-parenthesis)
;; (global-set-key (kbd "C-c [")  'insert-brackets)
;; (global-set-key (kbd "C-c ]")  'insert-brackets)

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++ BASICS KEYS +++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; might desire to add
;; (global-set-key [M-return] 'expand-abbrev)
;; (global-set-key [next]     'pager-page-down)
;; (global-set-key [prior]    'pager-page-up)
;; (global-set-key '[M-up]    'pager-row-up)
;; (global-set-key '[M-down]  'pager-row-down)


;; KEYBOARD SHORTCUTS
(global-set-key (kbd "C-x C-SPC") 'compile-again) ;; compile
(global-set-key (kbd "C-x SPC") 'compile-again) ;; compile
(global-set-key (kbd "C-c r") 'replace-regexp) ;; regex replace
(global-set-key (kbd "C-x x c") 'eshell) ;;  start shell
(global-set-key [f1] 'man-follow) ;; find man page
;; (global-set-key [f2] 'autofill-mode) ;; max 80 chars per line
(global-set-key (kbd "C-x x s l") 'list-matching-lines) ;; Regex search and show in other buffer

;; TAGS
(global-set-key (kbd "C-x x t r") 'tags-reset-tags-tables);; Reset tags table
(global-set-key (kbd "C-x x t v") 'visit-tags-table) ;; Visit tags table


;; UNDO TREE
(global-undo-tree-mode) ;; set undo tree mode
(global-set-key (kbd "C-x x u") 'undo-tree-visualize) ;; show undo tree


;; comment uncomment
(global-set-key (kbd "C-c c") 'comment-or-uncomment-region) ;; un/comment region
(global-set-key (kbd "C-c C-c") 'comment-or-uncomment-region) ;; un/comment region
(global-set-key (kbd "C-c TAB") 'iwb) ;; intend whole buffer
(global-set-key (kbd "C-x TAB") 'iwb) ;; intend whole buffer


;; move to another buffer easily
(global-set-key [M-left] 'windmove-left)          ; move to left windnow
(global-set-key [M-right] 'windmove-right)        ; move to right window
(global-set-key [M-up] 'windmove-up)              ; move to upper window
(global-set-key [M-down] 'windmove-down)          ; move to downer window

;; resize window buffers
;; (global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
;; (global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
;; (global-set-key (kbd "S-C-<down>") 'shrink-window)
;; (global-set-key (kbd "S-C-<up>") 'enlarge-window)

;; change some command
; (global-set-key (kbd "C-x x h") 'help-command)
; (global-set-key (kbd "C-h") 'delete-backward-char)
; (global-set-key (kbd "M-h") 'backward-kill-word)


;; don't kill emacs that easily
(defun dont-kill-emacs ()
  (interactive)
  (error (substitute-command-keys "To exit emacs: \\[save-buffers-kill-emacs]")))

(global-set-key "\C-x\C-c" 'dont-kill-emacs)
(global-set-key (kbd "C-x x C-q") 'save-buffers-kill-emacs)


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++ TOGGLE LINE TRUNCATION +++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(setq-default truncate-lines 0)
(global-set-key [f12] 'toggle-truncate-lines)


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++ FLYMAKE CONFIGURATION ++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


;; FLYMAKE (ENHANCEMENTS)
; n(global-set-key (kbd "C-x x n") 'my-flymake-show-next-error)
; (global-set-key (kbd "C-x x p") 'my-flymake-show-prev-error)

;; ASOCIATE KEY FOR CURRENT ERROR POPUP/MINIBUFFER
 ; (global-set-key (kbd "C-x x e") 'flymake:display-err-popup-for-current-line)
;;(global-set-key (kbd "C-x x e") 'flymake:display-err-minibuf-for-current-line)


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++ SPECIAL PACKAGES KEYS ++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



;; ETAGS
;; `M-.’ (‘find-tag’) – find a tag, that is, use the Tags file to look up a definition. If there are multiple tags in the project with the same name, use `C-u M-.’ to go to the next match.
;; `M-*’ (‘pop-tag-mark’) – jump back
;; ‘M-x tags-search’ – regexp-search through the source files indexed by a tags file (a bit like ‘grep’)
;; ‘M-x tags-query-replace’ – query-replace through the source files indexed by a tags file
;; `M-,’ (‘tags-loop-continue’) – resume ‘tags-search’ or ‘tags-query-replace’ starting at point in a source file
;; ‘M-x tags-apropos’ – list all tags in a tags file that match a regexp
;; ‘M-x list-tags’ – list all tags defined in a source file



;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++ GLOBAL HOOKS ++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; SAVE HOOKS
; (add-hook 'auto-save-hook 'my-desktop-save)
; (add-hook 'after-save-hook 'recreate-tags)
;; auto recompile all .el files
;; (add-hook 'after-save-hook 'byte-compile-current-buffer) ;; DISABLED , NOT WORKING

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++ MULTIPLE CURSORS CONFIG ++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; KEYS

;;When you have an active region that spans multiple lines, the following will
;;add a cursor to each line:
(global-set-key  (kbd "C-x x m r") 'mc/edit-lines)

;; When you want to add multiple cursors not based on continuous lines, but
;; based on keywords in the buffer, use:
(global-set-key  (kbd "C-x x m m") 'mc/mark-more-like-this-extended)
(global-set-key  (kbd "C-x x m n") 'mc/mark-next-like-this)
(global-set-key  (kbd "C-x x m p") 'mc/mark-previous-like-this)
(global-set-key  (kbd "C-x x m a") 'mc/mark-all-like-this)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; keybindings_hooks.el ends here
