;;; init.el ---
;;
;; Filename: init.el
;; Description:
;; Author: Manuel Schneckenreither
;; Maintainer:
;; Created: Fr Okt  4 20:33:29 2013 (+0200)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Mi Mär 26 10:55:26 2014 (+0100)
;;           By: Manuel Schneckenreither
;;     Update #: 549
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
;; MERCHANT ABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
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

;; define folder variables
(defvar home-folder (substitute-in-file-name "$HOME/"))
(defvar load-emacsd (concat home-folder ".emacs.d/") "The .emacs.d folder path.")

;; the settings file name to load
(load-file (concat load-emacsd "settings.el"))


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++++ EMACS SERVER +++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


;; start emacs as a server. You can then connect to it by invoking emacsclient.
(server-start)

;; and handle C-x k command just normally
(add-hook 'server-switch-hook
  (lambda ()
    (local-set-key (kbd "C-x k") '(lambda ()
                                    (interactive)
                                    (if server-buffer-clients
                                        (server-edit)
                                      (ido-kill-buffer))))))

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++++ LOAD PACKAGES ++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


;; GNU cflow comes with an emacs module providing a major mode for
;; visiting flow charts in GNU Emacs.
(autoload 'cflow-mode "cflow-mode")
(setq auto-mode-alist (append auto-mode-alist
                              '(("\\.cflow$" . cflow-mode))))
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
        android-mode
        auctex
        auto-complete
        auto-complete-auctex
        auto-dictionary
        ;; backup-each-save ;;; solved differently, see backup_each_save_config.el
        backup-walker
        bbdb
        bookmark+
        color-theme
        dired+
        ecb
        edbi
        flycheck
        flycheck-haskell
        flycheck-color-mode-line
        flycheck-ledger
        git-commit-mode
        git-rebase-mode
        ghci-completion
        gnuplot
        gnuplot-mode
        haskell-mode
        header2
        ido-gnus
        ido-hacks
        ido-ubiquitous
        javadoc-lookup
        javap-mode
        latex-pretty-symbols
        latex-extra
        magit
        multiple-cursors
        org
        org-plus-contrib
        pager
        pager-default-keybindings
        popup
        powerline
        rainbow-delimiters
        rainbow-mode
        color-theme-solarized
        thesaurus
        tuareg
        undo-tree
        w3m
        wide-n
        window-number
        yasnippet
        zenburn-theme
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

(defvar load-emacsversion (eval '(substring (emacs-version nil) 10 12) "/"))
(defvar load-folder (concat load-emacsd load-emacsversion "/"))

(defvar package-folder (concat load-folder "packages/"))
(defvar package-conf-folder (concat load-folder "packages_configs/"))
(defvar language-conf-folder (concat load-folder "language_configs/"))


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++ LOAD EMACS CONFIGS +++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; init everything else
(load (concat load-folder "emacs.el"))

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++ COLOR THEME +++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(require 'color-theme)
(color-theme-initialize)
(color-theme-dark-laptop)
;; eval following to use standard theme:
;; (color-theme-standard)

;; Color theme solarized
;; (color-theme-solarized-dark)

;; (defun color-my-emacs-default ()
;;   "Revert to default emacs theme."
;;   (interactive)
;;   (color-theme-standard))

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
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/.bookmarks")
 '(bookmark-default-file "/home/schnecki/.emacs.d/.bookmarks")
 '(color-theme-legal-frame-parameters "\\(color\\|mode\\|font\\|height\\|width\\)$")
 '(column-number-mode t)
 '(cua-delete-selection nil)
 '(custom-safe-themes (quote ("0f0e3af1ec61d04ff92f238b165dbc6d2a7b4ade7ed9812b4ce6b075e08f49fe" "f350c66dcff6db73192c4819363b7c1992931841e5ab381b1ed57ef8257a498f" default)))
 '(delete-active-region nil)
 '(dired-kept-versions 10)
 '(display-time-mode t)
 '(ecb-auto-expand-tag-tree (quote all))
 '(ecb-auto-expand-tag-tree-collapse-other (quote only-if-on-tag))
 '(ecb-display-image-icons-for-semantic-tags nil)
 '(ecb-expand-methods-switch-off-auto-expand nil)
 '(ecb-jde-set-directories-buffer-to-jde-sourcepath (quote replace))
 '(ecb-layout-name "left-methods-sources")
 '(ecb-layout-window-sizes (quote (("left-methods-sources" (ecb-methods-buffer-name 0.15546218487394958 . 0.6911764705882353) (ecb-sources-buffer-name 0.15546218487394958 . 0.29411764705882354)) ("left8" (ecb-directories-buffer-name 0.15126050420168066 . 0.29411764705882354) (ecb-sources-buffer-name 0.15126050420168066 . 0.23529411764705882) (ecb-methods-buffer-name 0.15126050420168066 . 0.29411764705882354) (ecb-history-buffer-name 0.15126050420168066 . 0.16176470588235295)))))
 '(ecb-method-face (quote ecb-default-highlight-face))
 '(ecb-methods-general-face (quote ecb-default-general-face))
 '(ecb-options-version "2.40")
 '(ecb-source-path (quote (("/" "/"))))
 '(ecb-type-tag-expansion (quote ((default) (c-mode "struct"))))
 '(ecb-use-speedbar-instead-native-tree-buffer nil)
 '(ede-project-directories (quote ("/home/schnecki/Documents/UIBK/5.Semester/NP/PS/06/01-ThreadPoolExecutor/src" "/home/schnecki/Documents/UIBK/5.Semester/NP/PS/06/01-ThreadPoolExecutor" "/home/schnecki/Programmierung/Java/BetPredictionTest/src" "/home/schnecki/Programmierung/Java/BetPredictionTest" "/tmp/myproject/include" "/tmp/myproject/src" "/tmp/myproject")))
 '(flymake-compilation-prevents-syntax-check nil)
 '(flymake-gui-warnings-enabled nil)
 '(frame-background-mode (quote dark))
 '(haskell-font-lock-haddock t)
 '(haskell-program-name "ghci -DDEBUG -fbreak-on-error" t)
 '(help-at-pt-display-when-idle (quote (flymake-overlay)) nil (help-at-pt))
 '(help-at-pt-timer-delay 0.1)
 '(jde-compile-option-directory "./../classes")
 '(jde-compiler (quote ("javac")))
 '(jde-global-classpath (quote ("./../classes" "./../lib")))
 '(jde-jdk (quote ("1.6")))
 '(jde-jdk-registry (quote (("1.6" . "/usr/lib/jvm/java-1.7.0") ("1.6OpenJDK" . "/usr/lib/jvm/java-1.7.0-openjdk"))))
 '(jde-sourcepath (quote ("./src/main" "./src/test")))
 '(kept-new-versions 5000)
 '(org-agenda-files (quote ("~/Documents/Planning/planning_time.org" "~/Documents/Planning/university.org" "~/Documents/Planning/bachelorarbeit.org" "~/Documents/Planning/ProjectIdeas.org" "~/Documents/Planning/freetime.org" "~/Documents/Planning/lists.org" "~/Documents/Planning/anniverseries.org" "~/Documents/Planning/Emacs.org" "~/Programmierung/App/Documentation/app-brainstorming.txt" "~/.emacs.d/org/notes.org")))
 '(send-mail-function (quote smtpmail-send-it))
 '(size-indication-mode t)
 '(smtpmail-smtp-server "smtp.uibk.ac.at")
 '(smtpmail-smtp-service 587)
 '(solarized-contrast (quote high))
 '(tool-bar-mode nil)
 '(tramp-default-method "ssh")
 '(user-full-name your-full-name)
 '(user-mail-address your-mail-address)
 '(yas-prompt-functions (quote (yas-ido-prompt yas-dropdown-prompt yas-completing-prompt yas-x-prompt yas-no-prompt))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-marker-1 ((t nil)))
 '(ecb-default-highlight-face ((t (:background "gray30"))))
 '(flymake-errline ((((class color)) (:underline (:style wave :color "Red1")))))
 '(flymake-warnline ((((class color)) (:underline (:style wave :color "DarkOrange")))))
 '(highlight-current-line-face ((t (:background "gray5"))) t)
 '(rainbow-delimiters-depth-1-face ((t (:foreground "red"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "magenta"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "cyan"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "brown"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "violet"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "green"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "yellow"))))
 '(rainbow-delimiters-depth-9-face ((t (:foreground "orange")))))


(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init.el ends here
(put 'narrow-to-region 'disabled nil)
