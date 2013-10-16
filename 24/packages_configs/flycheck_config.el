;;; package -- flycheck_config.el ---
;;; Commentary:
;;
;; Filename: flycheck_config.el
;; Status:
;; Author: Manuel Schneckenreither
;; Created: Mo Sep  2 22:29:02 2013 (+0200)
;; Version:
;; Last-Updated:
;;           By:
;;     Update #: 12
;; URL:
;; Description:
;;
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:



;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++ FLYCHECK COONFIG ++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


;; Enable flycheck for all buffers
;; (add-hook 'after-init-hook 'global-flycheck-mode)

;; (add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode)


;; (require 'flycheck-color-mode-line)

;; (eval-after-load "flycheck"
;;   (add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))



(global-flycheck-mode t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; flycheck_config.el ends here
