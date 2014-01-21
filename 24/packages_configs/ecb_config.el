;;; ecb_config.el ---
;;
;; Filename: ecb_config.el
;; Description:
;; Author: Manuel Schneckenreither
;; Maintainer:
;; Created: So Okt 13 16:30:34 2013 (+0200)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Di Jan 21 23:45:41 2014 (+0100)
;;           By: Manuel Schneckenreither
;;     Update #: 8
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


;; START ECB, BUT WITHOUT THE TIP OF THE DAY
(require 'ecb)
(ecb-byte-compile)
(setq ecb-tip-of-the-day nil)
(ecb-activate)


;; rest of ecb config can be found in init.el
;; under BASIC INFO in custom-set-variables!


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; ecb_config.el ends here
