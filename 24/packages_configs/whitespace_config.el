;;; column_marker_config.el ---
;;
;; Filename: column_marker_config.el
;; Description:
;; Author: Manuel Schneckenreither
;; Maintainer:
;; Created: Mo Okt 14 18:48:42 2013 (+0200)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Thu Jan 28 19:52:38 2016 (+0100)
;;           By: Manuel Schneckenreither
;;     Update #: 27
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
;; +++++++++++++++++++++++++ WHITESPACE MODE ++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


(require 'whitespace)
;; highlight all columns > 80 (default value)
;; (setq whitespace-style '(face empty tabs lines-tail trailing))
(setq whitespace-style '(face  tabs lines-tail trailing))

(setq whitespace-line-column 90)
(setq-default fill-column 90) 

(global-whitespace-mode t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; column_marker_config.el ends here
