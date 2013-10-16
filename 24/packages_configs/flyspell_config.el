;;; flyspell_config.el ---
;;
;; Filename: flyspell_config.el
;; Description:
;; Author: Manuel Schneckenreither
;; Maintainer:
;; Created: Fr Okt  4 20:40:17 2013 (+0200)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Mo Okt 14 19:55:37 2013 (+0200)
;;           By: Manuel Schneckenreither
;;     Update #: 53
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
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:


(require 'auto-dictionary)
;; (add-hook 'flyspell-mode-hook (lambda () (auto-dictionary-mode 1)))
;; (setq flyspell-issue-welcome-flag nil) ;; fix flyspell problem

;; (autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)
(add-hook 'message-mode-hook 'turn-on-flyspell)
(add-hook 'text-mode-hook 'turn-on-flyspell)

;; ;; WHEN ENABLED IT BREAKS AUTO-COMPLETION (AUTO-COMPLETE) FOR JAVA - workaround
;; ;; in auto_complete_config.el needs therefore to be enabled!
;; (add-hook 'jde-mode-hook (lambda () (flyspell-mode))) ;; prog for

;; (add-hook 'tcl-mode-hook 'flyspell-mode)
(add-hook 'latex-mode-hook (lambda () (flyspell-mode)))
;; (add-hook 'org-mode-hook (lambda () (flyspell-mode)))
;; (add-hook 'c++-mode-hook (lambda () (flyspell-mode)))
;; (add-hook 'c-mode-hook (lambda () (flyspell-mode)))
;; (add-hook 'emacs-lisp-mode-hook (lambda () (flyspell-mode)))
;; (add-hook 'haskell-mode-hook (lambda () (flyspell-mode)))


;; (defun turn-on-flyspell ()
;;   "Force 'flyspell-mode' on using a positive arg.  For use in hooks."
;;    (interactive)
;;    (flyspell-mode 1))

;; (turn-on-flyspell)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; flyspell_config.el ends here
