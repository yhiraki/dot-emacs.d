;;; counsel_config.el ---
;;
;; Filename: counsel_config.el
;; Description:
;; Author: Manuel Schneckenreither
;; Maintainer:
;; Created: Fri Aug 10 12:53:10 2018 (+0200)
;; Version:
;; Package-Requires: ()
;; Last-Updated:
;;           By:
;;     Update #: 5
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


(require 'ivy)
(require 'counsel)


(ivy-mode 1)
;; add ‘recentf-mode’ and bookmarks to ‘ivy-switch-buffer’.
(setq ivy-use-virtual-buffers t)
;; number of result lines to display
(setq ivy-height 10)
;; does not count candidates
(setq ivy-count-format "")
;; no regexp by default
(setq ivy-initial-inputs-alist nil)
;; configure regexp engine.
(setq ivy-re-builders-alist
      ;; allow input not in order
      '((t   . ivy--regex-ignore-order)))
(setq ivy-wrap t)

(global-unset-key (kbd "C-x b"))
;; (global-set-key (kbd "C-x b")                        'helm-mini)
(global-set-key (kbd "C-x b")                        'ivy-switch-buffer)
(global-set-key (kbd "C-x C-f")                      'counsel-find-file)
(global-set-key (kbd "C-c y") 'counsel-yank-pop)
(global-set-key (kbd "C-x C-m")                      'counsel-M-x)
(global-set-key (kbd "M-x")                          'counsel-M-x)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; counsel_config.el ends here
