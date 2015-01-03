;;; init.el ---
;;
;; Filename: init.el
;; Description:
;; Author: Manuel Schneckenreither
;; Maintainer:
;; Created: Tue Jul 29 00:11:38 2014 (+0200)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Wed Dec 24 15:44:34 2014 (+0100)
;;           By: Manuel Schneckenreither
;;     Update #: 535
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

;; (toggle-debug-on-quit)
;; (setq debug-on-error t)

;; DEBUG WITH

;; I assume only emacs is stuck, so you can open an xterm: what does ``ps
;; awlx | grep emacs'' say?  In particular, the state and the wchan are of
;; interest: normally, it should be in S state and waiting on select: idle
;; and waiting for input. If it's persistently in D state, it's stuck
;; somewhere in the kernel - the wchan gives an idea where. Do it a few times
;; to make sure that things are not changing.

;; The next step is to do ``strace -p<emacs_pid>'' to see whether it's going
;; in and out of the kernel (perhaps in an infinite loop).

;; If it is *not* going into the kernel, but accumulates CPU runtime (check
;; the ps awlx output a few times), then it's stuck in a loop in user
;; space. Attaching to it with ``gdb -p<emacs_pid>'' and getting a
;; backtrace should give an idea of where it's stuck. But if the loop is in
;; lisp code, the backtrace is not going to tell you where: it'll just be
;; in eval. If that's the case, then bisecting through your .emacs setup is
;; probably the best idea (maybe start by commenting out the org/wanderlust
;; stuff, particularly if you started getting these problems recently,
;; after making changes to their configuration.)

;; It's always a good idea to do these things with a working emacs first, so
;; that you learn what "normal" looks like. Then you have a better idea
;; of what's wrong when you try them on the stuck emacs.

;; This only scratches the surface but...

;; HTH,
;; Nick

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
(require 'server)
(unless (server-running-p)
  (server-start))

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
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/") t)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
  ;; (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
  (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t))


;; packages to be loaded
(setq jpk-packages
      '(
        ac-c-headers
        ac-dabbrev
        ac-ispell                       ; config in auto_complete_config.el
        ac-math
        ac-octave
        ace-jump-mode
        ace-jump-buffer                 ; config in ace-jump-mode config
        ace-window                      ; config in ace-jump-mode config
        android-mode
        auctex
        auto-complete
        auto-complete-auctex
        auto-complete-c-headers
        auto-complete-clang
        auto-dictionary
        arduino-mode
        ;; backup-each-save ;;; solved differently, see backup_each_save_config.el
        backup-walker
        bbdb
        bookmark+
        cdlatex
        change-inner
        color-theme
        color-theme-solarized
				dired+
        ecb
        edbi
        expand-region
        flycheck
        flycheck-haskell
        flycheck-color-mode-line
				flycheck-google-cpplint
				flycheck-ledger
        function-args
        fuzzy
        git-commit-mode
        git-rebase-mode
        ghci-completion
        gnuplot
        gnuplot-mode
        haskell-mode
        header2
        helm
        helm-bibtex
        helm-c-yasnippet
        helm-dired-recent-dirs
        helm-flycheck
        helm-git
        helm-git-files
        helm-google
        helm-hoogle
        helm-mode-manager
        ido-gnus
        ido-hacks
        ido-ubiquitous
        javadoc-lookup
        javap-mode
        jedi
        latex-pretty-symbols
        latex-extra
        magit
        multiple-cursors
        org
        org-ac
        org-cua-dwim
        org-eldoc
        org-plus-contrib
        orgtbl-ascii-plot
        ov
        pager
        pager-default-keybindings
        paredit
        popup
        powerline
        rainbow-delimiters
        rainbow-mode
        shakespeare-mode
        shm
        tex-smart-umlauts
        thesaurus
        tuareg
        undo-tree
        w3m
        wide-n
        window-number
        yasnippet
        zenburn-theme
        ))


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
(modify-frame-parameters nil '((wait-for-wm . nil)))
(load (concat load-folder "emacs.el"))

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++ COLOR THEME +++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(require 'color-theme)
(color-theme-initialize)
;;(color-theme-dark-laptop)
;; eval following to use standard theme:
;; (color-theme-standard)

;; Color theme solarized
(color-theme-solarized-dark)
;; (color-theme-solarized-light)

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
 '(Flymake-compilation-prevents-syntax-check nil)
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/.bookmarks")
 '(color-theme-legal-frame-parameters "\\(color\\|mode\\|font\\|height\\|width\\)$")
 '(column-number-mode t)
 '(cua-delete-selection nil)
 '(custom-safe-themes
   (quote
    ("0f0e3af1ec61d04ff92f238b165dbc6d2a7b4ade7ed9812b4ce6b075e08f49fe" "f350c66dcff6db73192c4819363b7c1992931841e5ab381b1ed57ef8257a498f" default)))
 '(delete-active-region nil)
 '(dired-kept-versions 10)
 '(display-time-mode t)
 '(ecb-auto-expand-tag-tree (quote all))
 '(ecb-auto-expand-tag-tree-collapse-other (quote only-if-on-tag))
 '(ecb-display-image-icons-for-semantic-tags nil)
 '(ecb-expand-methods-switch-off-auto-expand nil)
 '(ecb-jde-set-directories-buffer-to-jde-sourcepath (quote replace))
 '(ecb-layout-name "left-methods-sources")
 '(ecb-layout-window-sizes
   (quote
    (("left-methods-sources"
      (ecb-methods-buffer-name 0.15546218487394958 . 0.6911764705882353)
      (ecb-sources-buffer-name 0.15546218487394958 . 0.29411764705882354))
     ("left8"
      (ecb-directories-buffer-name 0.15126050420168066 . 0.29411764705882354)
      (ecb-sources-buffer-name 0.15126050420168066 . 0.23529411764705882)
      (ecb-methods-buffer-name 0.15126050420168066 . 0.29411764705882354)
      (ecb-history-buffer-name 0.15126050420168066 . 0.16176470588235295)))))
 '(ecb-method-face (quote ecb-default-highlight-face))
 '(ecb-methods-general-face (quote ecb-default-general-face))
 '(ecb-options-version "2.40")
 '(ecb-source-path (quote (("/" "/"))))
 '(ecb-type-tag-expansion (quote ((default) (c-mode "struct"))))
 '(ecb-use-speedbar-instead-native-tree-buffer nil)
 '(ede-project-directories
   (quote
    ("/home/schnecki/Documents/UIBK/7.Semester/InfoSec_SecArch/PS/08/03/src" "/home/schnecki/Documents/UIBK/7.Semester/InfoSec_SecArch/PS/08/03" "/home/schnecki/Documents/UIBK/7.Semester/InfoSec_SecArch/PS/06/04/src" "/home/schnecki/Documents/UIBK/7.Semester/InfoSec_SecArch/PS/06/04" "/home/schnecki/Documents/UIBK/7.Semester/C++/project/textyTex/src/model/framework" "/home/schnecki/Documents/UIBK/7.Semester/C++/project/textyTex/src/model/exceptions" "/home/schnecki/Documents/UIBK/7.Semester/C++/project/textyTex/src/model" "/home/schnecki/Documents/UIBK/7.Semester/C++/project/textyTex/src" "/home/schnecki/Documents/UIBK/7.Semester/C++/project/textyTex" "/home/schnecki/Documents/UIBK/7.Semester/InfoSec_SecArch/PS/05/04/src" "/home/schnecki/Documents/UIBK/7.Semester/InfoSec_SecArch/PS/05/04")))
 '(fill-column 80)
 '(flycheck-clang-include-path
   (quote
    ("/usr/include/gtkmm-3.0" "/usr/include/gdkmm-3.0" "/usr/include/glibmm-2.4" "/usr/include/gtkmm-3.0" "/usr/lib/gtkmm-3.0/include" "/usr/include/atkmm-1.6" "/usr/include/gtk-3.0/unix-print" "/usr/include/gdkmm-3.0" "/usr/lib/gdkmm-3.0/include" "/usr/include/giomm-2.4" "/usr/lib/giomm-2.4/include" "/usr/include/pangomm-1.4" "/usr/lib/pangomm-1.4/include" "/usr/include/glibmm-2.4" "/usr/lib/glibmm-2.4/include" "/usr/include/gtk-3.0" "/usr/include/at-spi2-atk/2.0" "/usr/include/at-spi-2.0" "/usr/include/dbus-1.0" "/usr/lib/dbus-1.0/include" "/usr/include/gtk-3.0" "/usr/include/gio-unix-2.0/" "/usr/include/cairo" "/usr/include/pango-1.0" "/usr/include/atk-1.0" "/usr/include/cairo" "/usr/include/cairomm-1.0" "/usr/lib/cairomm-1.0/include" "/usr/include/cairo" "/usr/include/pixman-1" "/usr/include/freetype2" "/usr/include/libpng16" "/usr/include/harfbuzz" "/usr/include/freetype2" "/usr/include/harfbuzz" "/usr/include/libdrm" "/usr/include/libpng16" "/usr/include/sigc++-2.0" "/usr/lib/sigc++-2.0/include" "/usr/include/gdk-pixbuf-2.0" "/usr/include/libpng16" "/usr/include/glib-2.0" "/usr/lib/glib-2.0/include")))
 '(flycheck-clang-includes (quote ("/usr/include/netdb.h")))
 '(flycheck-haskell-ghc-executable nil)
 '(flycheck-haskell-hlint-executable nil)
 '(flymake-gui-warnings-enabled nil)
 '(frame-background-mode (quote dark))
 '(global-flycheck-mode t nil (flycheck))
 '(gnus-topic-display-empty-topics nil)
 '(help-at-pt-display-when-idle (quote (flymake-overlay)) nil (help-at-pt))
 '(help-at-pt-timer-delay 0.1)
 '(jde-compile-option-directory "./../classes")
 '(jde-compiler (quote ("javac")))
 '(jde-global-classpath (quote ("./../classes" "./../lib")))
 '(jde-jdk (quote ("1.6")))
 '(jde-jdk-registry (quote (("1.6" . "/usr/lib/jvm/java-default-runtime"))))
 '(jde-sourcepath (quote ("./src/main" "./src/test")))
 '(kept-new-versions 5000)
 '(mpc-data-directory "~/.emacs.d/.tmp/mpc")
 '(org-agenda-files
   (quote
    ("~/Documents/Planning/planning_time.org" "~/Documents/Planning/university.org" "~/Documents/Planning/ProjectIdeas.org" "~/Documents/Planning/freetime.org" "~/Documents/Planning/lists.org" "~/Documents/Planning/anniverseries.org" "~/Documents/Planning/Emacs.org" "~/Documents/Planning/jobcl.org" "~/Programmierung/App/Documentation/app-brainstorming.txt" "~/.emacs.d/org/notes.org")))
 '(send-mail-function (quote smtpmail-send-it))
 '(setq max-specpdl-size t)
 '(size-indication-mode t)
 '(smtpmail-smtp-server "smtp.uibk.ac.at")
 '(smtpmail-smtp-service 587)
 '(solarized-contrast (quote high))
 '(tool-bar-mode nil)
 '(tramp-default-method "ssh")
 '(user-full-name your-full-name)
 '(user-mail-address your-mail-address)
 '(yas-prompt-functions
   (quote
    (yas-ido-prompt yas-dropdown-prompt yas-completing-prompt yas-x-prompt yas-no-prompt))))

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
(put 'narrow-to-region 'disabled nil)


;; Open gnus if it is loaded and used does not decline
(if (fboundp 'gnus)
    (if (y-or-n-p-with-timeout "Open Gnus (You got 5 seconds do decline)? " 5 t)
        (gnus)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init.el ends here
