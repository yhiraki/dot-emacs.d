;;; auto_complete_config.el ---
;;
;; Filename: auto_complete_config.el
;; Description:
;; Author: Manuel Schneckenreither
;; Maintainer:
;; Created: So Okt 13 19:43:26 2013 (+0200)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Fr Jun  6 22:21:11 2014 (+0200)
;;           By: Manuel Schneckenreither
;;     Update #: 139
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
;; ++++++++++++++++++++++++++ SMART TABS MODE +++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(require 'auto-complete)

(define-key ac-completing-map [(tab)] 'ac-complete)
(define-key ac-completing-map "\r" nil) ;; disable completing by enter
;; (icomplete-mode +1) ;; complete mode in mini-buffer


;; flyspell and ac-complete don't like each other
(ac-flyspell-workaround)


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++++ ETAGS SOURCE  ++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(defface ac-etags-candidate-face
  '((t (:background "gainsboro" :foreground "deep sky blue")))
  "Face for etags candidate")

(defface ac-etags-selection-face
  '((t (:background "deep sky blue" :foreground "white")))
  "Face for the etags selected candidate.")

;; define a new source for auto complete (source from tags)
(defvar ac-source-etags
  '((candidates . (lambda ()
                    (all-completions ac-target (tags-completion-table))))
    (candidate-face . ac-etags-candidate-face)
    (selection-face . ac-etags-selection-face)
    (requires . 3))
  "Source for etags.")

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++ USER OPTIONS, VARIABLES +++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(set-face-background 'ac-candidate-face "lightgray")
(set-face-underline-p 'ac-candidate-face "darkgray")
(set-face-background 'ac-selection-face "steelblue")
;; (define-key ac-completing-map "." 'ac-complete)
;; (define-key ac-completing-map ";" 'ac-stop)
(setq ac-dwim t)
(setq ac-auto-show-menu 0.01)
(setq ac-auto-start t)
(setq ac-delay 0.01)
(setq ac-dictionary-directories (quote ("~/.emacs.d/.ac-dict")))
(setq ac-quick-help-delay 0.2)
(setq ac-ignore-case t)
(setq ac-use-menu-map t)
(setq ac-candidate-limit 100)  ;; maximize candidate number to prevent delays
(setq ac-use-fuzzy t)          ;; use fuzzy matching


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
              '(;; ac-source-abbrev          ;; edited
                ;; ac-source-css-property
                ;; ac-source-dictionary
                ;; ac-source-eclim
                ac-source-yasnippet
                ;; ac-source-symbols
								;; ac-source-filename
								;; ac-source-files-in-current-dir
                ;; ac-source-gtags
                ;; ac-source-etags
                ac-source-imenu
                ;; ac-source-semantic ;; slows down auto complete
                ;; ac-source-semantic-raw ;; slows down auto complete
                ;; ac-source-words-in-all-buffer
                ;; ac-source-words-in-buffer
                ac-source-words-in-same-mode-buffers
                ))


;; COMPLETION SOURCE FROM ISPELL

(eval-after-load "auto-complete"
  '(progn
     (ac-ispell-setup)))

(defun my/enable-ac-ispell ()
  (add-to-list 'ac-sources 'ac-source-ispell))

;; (add-hook 'git-commit-mode-hook 'my/enable-ac-ispell)
;; (add-hook 'mail-mode-hook 'my/enable-ac-ispell)
;; (add-hook 'message-mode-hook 'my/enable-ac-ispell)
;; (add-hook 'TeX-mode-hook 'my/enable-ac-ispell)

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;; auto_complete_config.el ends here
