;;; init.el ---
;;
;; Filename: init.el
;; Description:
;; Author: Manuel Schneckenreither
;; Maintainer:
;; Created: Fr Okt  4 20:33:29 2013 (+0200)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Sa Okt 26 21:13:39 2013 (+0200)
;;           By: Manuel Schneckenreither
;;     Update #: 174
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

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++ PERSONAL SETTINGS ++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; Edit your settings in settings.el
(setq emacsd "~/.emacs.d/")
(load-file (concat emacsd "settings.el"))


(autoload 'cflow-mode "cflow-mode")
(setq auto-mode-alist (append auto-mode-alist
                              '(("\\.cflow$" . cflow-mode))))

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++++ LOAD PACKAGES ++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/")))

;; packages to be loaded
(setq jpk-packages
      '(
        ac-dabbrev
        ac-math
        auctex
        auto-complete
        auto-dictionary
        ;; backup-each-save ;;; solved differently, see backup_each_save_config.el
        backup-walker
        ecb
        emacs-eclim
        flycheck
        gnuplot
        gnuplot-mode
        haskell-mode
        header2
        javadoc-lookup
        javap-mode
        latex-pretty-symbols
        magit
        multiple-cursors
        org
        org-plus-contrib
        popup
        thesaurus
        undo-tree
        window-number
        yasnippet
        ))

(package-initialize)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives
             '("org" . "http://orgmode.org/elpa/"))

(when (not package-archive-contents)
  (package-refresh-contents))

(dolist (pkg jpk-packages)
  (when (and (not (package-installed-p pkg))
             (assoc pkg package-archive-contents))
    (package-install pkg)))

(defun package-list-unaccounted-packages ()
  "Like `package-list-packages', but shows only the packages that
  are installed and are not in `jpk-packages'.  Useful for
  cleaning out unwanted packages."
  (interactive)
  (package-show-package-list
   (remove-if-not (lambda (x) (and (not (memq x jpk-packages))
                            (not (package-built-in-p x))
                            (package-installed-p x)))
                  (mapcar 'car package-archive-contents))))

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++ SET FOLDER VARIABLE ++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(setq emacsversion (eval '(substring (emacs-version nil) 10 12) "/"))
(setq folder
      (concat emacsd emacsversion "/"))
;; TODO (setq folder "24/") ;; emacs-major-version)
(setq package_folder (concat folder "packages/"))
(setq package_conf_folder (concat folder "packages_configs/"))
(setq language_conf_folder (concat folder "language_configs/"))

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++ LOAD EMACS CONFIGS +++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; load cedet
;; (load (concat package_conf_folder "cedet_config.el"))
;; init everything else
(load (concat folder "emacs.el"))

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++ COLOR THEME +++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(require 'color-theme)
(color-theme-initialize)
(color-theme-dark-laptop)
;; eval following to use standard theme:
;; (color-theme-standard)

(defun color-my-emacs-default ()
  "Revert to default emacs theme."
  (interactive)
  (color-theme-standard))

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++ BASIC INFO ++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; SOME BASIC AND COMMON PARAMETERS
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-quick-help-delay 0.1)
 '(ac-show-menu-immediately-on-auto-complete t)
 '(auto-save-file-name-transforms (quote ((".*" "~/.emacs.d/.tmp/autosaves/\\1" t))))
 '(backup-directory-alist (quote ((".*" . "~/.emacs.d/.tmp/backups/"))))
 '(column-number-mode t)
 '(display-time-mode t)
 '(ecb-jde-set-directories-buffer-to-jde-sourcepath (quote replace))
 '(ecb-layout-window-sizes (quote (("left8" (ecb-directories-buffer-name 0.15126050420168066 . 0.29411764705882354) (ecb-sources-buffer-name 0.15126050420168066 . 0.23529411764705882) (ecb-methods-buffer-name 0.15126050420168066 . 0.29411764705882354) (ecb-history-buffer-name 0.15126050420168066 . 0.16176470588235295)))))
 '(ecb-options-version "2.40")
 '(haskell-font-lock-haddock t)
 '(jde-compile-option-directory "./../classes")
 '(jde-compiler (quote ("javac")))
 '(jde-flymake-option-jikes-source "1.7")
 '(jde-global-classpath (quote ("./../classes" "./../lib")))
 '(jde-jdk (quote ("1.6")))
 '(jde-jdk-registry (quote (("1.6" . "/usr/lib/jvm/java-1.7.0") ("1.6OpenJDK" . "/usr/lib/jvm/java-1.7.0-openjdk"))))
 '(jde-sourcepath (quote ("./src/main" "./src/test")))
 '(org-agenda-files (quote ("~/Documents/Planning/planning_time.org" "~/Documents/Planning/university.org" "~/Documents/Planning/bachelorarbeit.org" "~/Documents/Planning/ProjectIdeas.org" "~/Documents/Planning/freetime.org" "~/Documents/Planning/lists.org" "~/Documents/Planning/Emacs.org")))
 ;; '(org-agenda-skip-additional-timestamps-same-entry t)
 ;; '(org-agenda-skip-scheduled-if-deadline-is-shown (quote repeated-after-deadline))
 '(size-indication-mode t)
 '(tool-bar-mode nil)
 '(user-full-name your-full-name)
 '(user-mail-address your-mail-address)
 '(version-control t)
 '(yas-prompt-functions (quote (yas-ido-prompt yas-dropdown-prompt yas-completing-prompt yas-x-prompt yas-no-prompt))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-marker-1 ((t nil)))
 '(flymake-errline ((((class color)) (:underline "red"))))
 '(flymake-warnline ((((class color)) (:underline "yellow"))))
 '(highlight-current-line-face ((t (:background "gray5")))))

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init.el ends here
