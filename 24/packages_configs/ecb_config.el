;;; ecb_config.el --- 
;; 
;; Filename: ecb_config.el
;; Description: 
;; Author: Manuel Schneckenreither
;; Maintainer: 
;; Created: So Okt 13 16:30:34 2013 (+0200)
;; Version: 
;; Package-Requires: ()
;; Last-Updated: So Okt 13 17:29:17 2013 (+0200)
;;           By: Manuel Schneckenreither
;;     Update #: 6
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




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; ecb_config.el ends here
