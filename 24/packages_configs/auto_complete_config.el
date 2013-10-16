;; ;;; auto_complete_config.el ---
;; ;;
;; ;; Filename: auto_complete_config.el
;; ;; Description:
;; ;; Author: Manuel Schneckenreither
;; ;; Maintainer:
;; ;; Created: So Okt 13 19:43:26 2013 (+0200)
;; ;; Version:
;; ;; Package-Requires: ()
;; ;; Last-Updated: Mi Okt 16 16:16:01 2013 (+0200)
;; ;;           By: Manuel Schneckenreither
;; ;;     Update #: 71
;; ;; URL:
;; ;; Doc URL:
;; ;; Keywords:
;; ;; Compatibility:
;; ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;
;; ;;; Commentary:
;; ;;
;; ;;
;; ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;
;; ;;; Change Log:
;; ;;
;; ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;
;; ;;; Code:

;; ;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ;; ++++++=+++++++++++++++++++ SMART TABS MODE +++++++++++++++++++++++++++
;; ;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(define-key ac-completing-map [(tab)] 'ac-complete) ;; enable completing by tab
(define-key ac-completing-map "\r" nil) ;; disable completing by enter
;; (icomplete-mode +1) ;; complete mode in minibuffer

;; (ac-flyspell-workaround)

;; (set-default 'ac-sources
;; ;; '(ac-source-abbrev
;; ;; ac-source-dictionary
;; ;; ac-source-yasnippet
;; ;; ac-source-words-in-buffer
;; ;; ac-source-words-in-same-mode-buffers
;; ;; ac-source-semantic))

;; ;; (ac-config-default)

;; ;; (dolist (m '(c-mode c++-mode java-mode))
;; ;; (add-to-list 'ac-modes m))

;;;;##########################################################################
;;;;  User Options, Variables
;;;;##########################################################################

(defface ac-etags-candidate-face
  '((t (:background "gainsboro" :foreground "deep sky blue")))
  "Face for etags candidate")

(defface ac-etags-selection-face
  '((t (:background "deep sky blue" :foreground "white")))
  "Face for the etags selected candidate.")

(defvar ac-source-etags
  '((candidates . (lambda ()
                    (all-completions ac-target (tags-completion-table))))
    (candidate-face . ac-etags-candidate-face)
    (selection-face . ac-etags-selection-face)
    (requires . 3))
  "Source for etags.")

(set-face-background 'ac-candidate-face "lightgray")
(set-face-underline-p 'ac-candidate-face "darkgray")
(set-face-background 'ac-selection-face "steelblue")
;; (define-key ac-completing-map "." 'ac-complete)
;; (define-key ac-completing-map ";" 'ac-stop)
(setq ac-dwim t)
(setq ac-auto-show-menu 0.01)
(setq ac-auto-start 1)
(setq ac-delay 0.01)
(setq ac-dictionary-directories (quote ("~/.emacs.d/.ac-dict")))
(setq ac-quick-help-delay 0.2)
(setq ac-ignore-case t)
(setq ac-use-menu-map t)

;; use C-p and C-n to navigate in menu
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)

;; dirty fix for having AC everywhere
(define-globalized-minor-mode real-global-auto-complete-mode
  auto-complete-mode (lambda ()
                       (if (not (minibufferp (current-buffer)))
                         (auto-complete-mode 1))
                       ))
(real-global-auto-complete-mode t)

;; configure sources
;; (ac-config-default)
;; global sources
(setq-default ac-sources
   '(ac-source-abbrev
     ;; ac-source-css-property
     ac-source-dictionary
     ;; ac-source-eclim
     ac-source-etags
     ac-source-yasnippet
     ac-source-filename
     ac-source-files-in-current-dir
     ;; ac-source-gtags
     ac-source-imenu
     ac-source-semantic
     ac-source-semantic-raw
     ;;ac-source-words-in-all-buffer
     ac-source-words-in-buffer
     ac-source-words-in-same-mode-buffers
     ))

;; ;; (add-hook 'jde-mode (lambda () (add-to-list 'jde)))

;; (defvar ac-ispell-modes
;;   '(text-mode))

;; (defun ac-ispell-candidate ()
;;   (if (memq major-mode ac-ispell-modes)
;;    (let ((word (ispell-get-word nil "\\*")))
;;      (setq word (car word))
;;      (lookup-words (concat word "*") ispell-complete-word-dict))))

;; (defvar ac-source-ispell
;;   '((candidates . ac-ispell-candidate)
;;     (requires . 3))
;;   "Source for ispell.")

;; ;; (defun my-ac-haskell-mode ()
;; ;;   (setq ac-sources '(ac-source-words-in-same-mode-buffers
;; ;;                      ac-source-dictionary
;; ;;                      ac-source-ghc-mod)))
;; ;; (add-hook 'haskell-mode-hook 'my-ac-haskell-mode)

;; ;; (set-default 'ac-sources
;; ;;              '(ac-source-semantic
;; ;;                ac-source-yasnippet
;; ;;                ac-source-abbrev
;; ;;                ac-source-words-in-buffer
;; ;;                ac-source-words-in-all-buffer
;; ;;                ac-source-imenu
;; ;;                ac-source-files-in-current-dir
;; ;;                ac-source-filename))

;; ;; (setq ac-trigger-commands '(self-insert-command autopair-insert-or-skip-quote))

;; ;; (defun ac-settings-4-eshell ()
;; ;;             (setq ac-sources
;; ;;                   '(;;ac-source-semantic
;; ;;                     ac-source-yasnippet
;; ;;                     ac-source-abbrev
;; ;;                     ac-source-words-in-buffer
;; ;;                     ac-source-words-in-all-buffer
;; ;;                     ac-source-files-in-current-dir
;; ;;                     ac-source-filename
;; ;;                     ac-source-symbols
;; ;;                     ac-source-imenu)))

;; ;; (defun ac-settings-4-text ()
;; ;;             (setq ac-sources
;; ;;                   '(;;ac-source-semantic
;; ;;                     ac-source-yasnippet
;; ;;                     ac-source-abbrev
;; ;;                     ac-source-words-in-buffer
;; ;;                     ac-source-words-in-all-buffer
;; ;;                     ac-source-imenu)))

;; ;; (defun ac-settings-4-lisp ()
;; ;;   "Auto complete settings for lisp mode."
;; ;;   (setq ac-omni-completion-sources '(("require\s+'" ac-source-emacs-lisp-features)
;; ;;                                      ("load\s+\"" ac-source-emacs-lisp-features)))
;; ;;   (setq ac-sources
;; ;;         '(ac-source-yasnippet
;; ;;           ac-source-symbols
;; ;;           ;; ac-source-semantic
;; ;;           ac-source-abbrev
;; ;;           ac-source-words-in-buffer
;; ;;           ac-source-words-in-all-buffer
;; ;;           ac-source-imenu
;; ;;           ac-source-files-in-current-dir
;; ;;           ac-source-filename)))

;; ;; (defun ac-settings-4-java ()
;; ;;   (setq ac-omni-completion-sources (list (cons "\\." '(ac-source-semantic))
;; ;;                                          (cons "->" '(ac-source-semantic))))
;; ;;   (setq ac-sources
;; ;;         '(;;ac-source-semantic
;; ;;           ac-source-yasnippet
;; ;;           ac-source-abbrev
;; ;;           ac-source-words-in-buffer
;; ;;           ac-source-words-in-all-buffer
;; ;;           ac-source-files-in-current-dir
;; ;;           ac-source-filename)))

;; ;; (defun ac-settings-4-html ()
;; ;;   (setq ac-sources
;; ;;         '(;;ac-source-semantic
;; ;;           ac-source-yasnippet
;; ;;           ac-source-abbrev
;; ;;           ac-source-words-in-buffer
;; ;;           ac-source-words-in-all-buffer
;; ;;           ac-source-files-in-current-dir
;; ;;           ac-source-filename)))

;; ;; (add-hook 'lisp-mode-hook   'ac-settings-4-lisp)
;; ;; (add-hook 'jde-mode-hook   'ac-settings-4-java)
;; ;; (add-hook 'text-mode-hook   'ac-settings-4-text)
;; ;; (add-hook 'shell-mode-hook 'ac-settings-4-eshell)
;; ;; (add-hook 'eshell-mode-hook 'ac-settings-4-eshell)
;; ;; (add-hook 'html-mode-hook   'ac-settings-4-html)

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;; auto_complete_config.el ends here
