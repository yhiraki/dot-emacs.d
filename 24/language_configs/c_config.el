;;; c_config.el ---
;;
;; Filename: c_config.el
;; Description:
;; Author: Manuel Schneckenreither
;; Maintainer:
;; Created: Fr Feb  7 00:07:46 2014 (+0100)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Fri Aug 29 16:38:31 2014 (+0200)
;;           By: Manuel Schneckenreither
;;     Update #: 58
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


(require 'cc-mode);

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++ SETTINGS FOR C LIKE LANGUAGES+++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; preferences
(c-set-offset 'substatement-open 0)
(c-set-offset 'case-label '+)
(c-set-offset 'arglist-cont-nonempty '+)
(c-set-offset 'arglist-intro '+)
(c-set-offset 'topmost-intro-cont '+)


;; CONFIGURE ELDOC INCLUDES
;; (setq c-eldoc-includes   "pkg-config gtk+-2.0 --cflags` -I./ -I../ ")

;; C-MODE HOOK
(setq auto-mode-alist (cons '("\.cl$" . c-mode) auto-mode-alist)) ;; OPENCL

;; (add-hook 'c-mode-hook 'turn-on-eldoc-mode)

;; Create and set tags table
(defun make-c-tags ()
  "This function reloads the tags by using the command 'make tags'."
  (interactive)
  (let ((dir (nth 0 (split-string default-directory "src"))))
    (setq esdir (replace-regexp-in-string " " "\\\\ " dir))
    (shell-command
     (concat "cd " esdir " && find . -name \"*.c\" -o -name \"*.h\" -o -name \"*.cpp\" -o -name \"*.hpp\" | etags - 1>/dev/null 2>/dev/null") nil)
    (visit-tags-table (concat dir "TAGS"))))

(require 'auto-complete-c-headers)

;; C MODE
(defun my-c-mode-hook ()


  ;; add auto-complete mode
  (add-to-list 'ac-sources 'ac-source-semantic) ;; slows down auto complete)
  (add-to-list 'ac-sources 'ac-source-abbrev)
  ;; (add-to-list 'ac-sources 'ac-source-css-property)
  (add-to-list 'ac-sources 'ac-source-dictionary)
  ;; (add-to-list 'ac-sources 'ac-source-eclim)
  (add-to-list 'ac-sources 'ac-source-yasnippet)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  ;; (add-to-list 'ac-sources 'ac-source-symbols)
  ;; (add-to-list 'ac-sources 'ac-source-filename)
  ;; (add-to-list 'ac-sources 'ac-source-files-in-current-dir)
  ;; (add-to-list 'ac-sources 'ac-source-gtags)
  (add-to-list 'ac-sources 'ac-source-etags)
  (add-to-list 'ac-sources 'ac-source-imenu)

  ;; (add-to-list 'ac-sources 'ac-source-semantic-raw) ;; slows down auto complete)
  ;; (add-to-list 'ac-sources 'ac-source-words-in-all-buffer)
  ;; (add-to-list 'ac-sources 'ac-source-words-in-buffer)
  ;; (add-to-list 'ac-sources 'ac-source-words-in-same-mode-buffers)


  ;; (setq ac-sources (append '(ac-source-semantic) ac-sources))

  ;; enable semantic for auto complete mode
  (semantic-mode t)

  ;; enable auto completion. If it doesn't work try to disable flyspell mode.
  (auto-complete-mode)

  ;; use programming flyspell mode
  (flyspell-prog-mode)

  ;; start auto completion after entering a dot: .
  (local-set-key (kbd ".") (lambda ()
                             (interactive)
                             (progn
                               (insert ".")
                               ;; (if (not (auto-complete-mode))
                               ;;     (auto-complete-mode t))
                               (auto-complete)
                               ;; (semantic-ia-complete-tip (point))
                               )))

  ;; start auto completion after entering >
  (local-set-key (kbd ">") (lambda ()
                             (interactive)
                             (progn
                               (insert ">")
                               ;; (if (not (auto-complete-mode))
                               ;;     (auto-complete-mode t))
                               (auto-complete)
                               ;; (semantic-ia-complete-tip (point))
                               )))

  (add-hook 'after-save-hook 'make-c-tags nil t)

  )

;; add hook
(add-hook 'c-mode-hook 'my-c-mode-hook)
(add-hook 'c++-mode-hook 'my-c-mode-hook)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; c_config.el ends here
