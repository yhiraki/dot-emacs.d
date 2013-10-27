;;; keybindings_hooks.el ---
;;
;; Filename: keybindings_hooks.el
;; Status:
;; Author: Manuel Schneckenreither
;; Created: So Sep 29 14:21:26 2013 (+0200)
;; Version:
;; Last-Updated:
;;           By:
;;     Update #: 68
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


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++ BASICS KEYS +++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; KEYBOARD SHORTCUTS
(global-set-key (kbd "C-x C-SPC") 'compile-again) ;; compile
(global-set-key (kbd "C-x SPC") 'compile-closest-Makefile) ;; compile
(global-set-key (kbd "C-c SPC") 'compile-closest-Makefile) ;; compile
(global-set-key [f1] 'man-follow) ;; find man page

(global-set-key (kbd (concat prefix-command-key " c")) 'eshell) ;;  start shell
(global-set-key (kbd (concat prefix-command-key " r")) 'replace-regexp) ;; regex replace
(global-set-key (kbd (concat prefix-command-key " s l")) 'list-matching-lines) ;; Regex search and show in other buffer

;; TAGS
(global-set-key (kbd (concat prefix-command-key " t r")) 'tags-reset-tags-tables);; Reset tags table
(global-set-key (kbd (concat prefix-command-key " t v")) 'visit-tags-table) ;; Visit tags table


;; UNDO TREE
(global-undo-tree-mode) ;; set undo tree mode
(global-set-key (kbd (concat prefix-command-key " u")) 'undo-tree-visualize) ;; show undo tree

;; AUTO FILL COLUMN
(global-set-key (kbd (concat prefix-command-key " a"))  'auto-fill-mode)

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

;; don't kill emacs that easily
(defun dont-kill-emacs ()
  (interactive)
  (error (substitute-command-keys "To exit emacs: \\[save-buffers-kill-emacs]")))

(global-set-key "\C-x\C-c" 'dont-kill-emacs)
(global-set-key (kbd (concat prefix-command-key " C-q")) 'save-buffers-kill-emacs)


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++ TOGGLE LINE TRUNCATION +++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(setq-default truncate-lines 0)
(global-set-key [f12] 'toggle-truncate-lines)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; keybindings_hooks.el ends here
