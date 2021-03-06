;;; init.el ---
;;
;; Filename: init.el
;; Description:
;; Author: Manuel Schneckenreither
;; Maintainer:
;; Created: Tue Jul 29 00:11:38 2014 (+0200)
;; Version:
;; Package-Requires: ()
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
	abs-mode
        ac-c-headers
        ac-capf
        ac-dabbrev
        ac-ispell                       ; config in auto_complete_config.el
        ac-etags
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
        bison-mode
        bookmark+
        browse-kill-ring
        cdlatex
        change-inner
        color-theme-modern
        company-auctex
        company-bibtex
        company-c-headers
        company-cabal
        ;; company-emacs-eclim
        company-ghc
        company-ghci
        company-math
				company-shell
        company-try-hard
        counsel
        dired+
        ecb
        ;; eclim
        edbi
        expand-region
        flycheck
        flycheck-hdevtools
        flycheck-haskell
        flycheck-color-mode-line
				flycheck-google-cpplint
				flycheck-ledger
        flyspell-correct
        flyspell-correct-helm
        function-args
        fuzzy
        git-commit-mode
        git-rebase-mode
        ghci-completion
        gnuplot
        gnuplot-mode
        hamlet-mode
        haskell-mode
        header2
        hindent
        hlint-refactor
        hayoo
        helm
        helm-bibtex
        helm-c-yasnippet
        helm-dired-recent-dirs
        helm-flycheck
        helm-flx
        helm-git
        helm-git-files
        helm-hayoo
        helm-google
        helm-hoogle
        helm-mode-manager
        htmlize
        ido-gnus
        ido-hacks
        ido-ubiquitous
        intero
        javadoc-lookup
        javap-mode
        jedi
        latex-pretty-symbols
        magit
        markdown-mode
        markdown-mode+
        markdown-toc
        matlab-mode
        multiple-cursors
        org
        org-ac
        org-cua-dwim
        org-eldoc
        org-gcal
        org-plus-contrib
        orgtbl-ascii-plot
        ov
        pager
        pager-default-keybindings
        paredit
        php-mode
        php-auto-yasnippets
        popup
        powerline
        rainbow-delimiters
        rainbow-mode
        shakespeare-mode
        shm
        smart-mode-line
        sml-mode
        tex-smart-umlauts
        thesaurus
        tuareg
        undo-tree
        vc-darcs
        w3m
        wide-n
        window-number
        yaml-mode
        yasnippet
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

(require 'color-theme-modern)
(defun load-my-theme ()
  (interactive)
  ;; (load-theme 'arjen t t)
  ;; (enable-theme 'arjen)
  (load-theme 'leuven t t)
  (enable-theme 'leuven)
  ;; (load-theme 'andreas t t)
  ;; (enable-theme 'andreas)
  )

(load-my-theme)

;; (load-theme 'subtle-hacker t t)
;; (enable-theme 'subtle-hacker)
;; (load-theme 'emacs-nw t t)
;; (enable-theme 'emacs-nw)

;; see https://github.com/emacs-jp/replace-colorthemes/blob/master/screenshots.md

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
 '(ac-etags-requires 1)
 '(auto-save-default nil)
 '(bmkp-last-as-first-bookmark-file "/home/schnecki/.emacs.d/.bookmarks")
 '(cedet-java-classpath-extension
   (quote
    ((concat
      (nth 0
           (split-string default-directory "src"))
      "./lib/")
     (concat
      (nth 0
           (split-string default-directory "src"))
      "./src/")
     (concat
      (nth 0
           (split-string default-directory "src"))
      "../Common/src/")
     (concat
      (nth 0
           (split-string default-directory "src"))
      "../Common/lib/"))))
 '(column-number-mode t)
 '(company-box-icons-alist (quote company-box-icons-icons-in-terminal))
 '(company-fuzzy-sorting-backend (quote flx))
 '(company-idle-delay 0.01)
 '(cua-delete-selection nil)
 '(custom-safe-themes
   (quote
    ("a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "cdc2a7ba4ecf0910f13ba207cce7080b58d9ed2234032113b8846a4e44597e41" default)))
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
 '(eclimd-autostart nil)
 '(ede-project-directories
   (quote
    ("/home/schnecki/Documents/UIBK/7.Semester/InfoSec_SecArch/PS/08/03/src" "/home/schnecki/Documents/UIBK/7.Semester/InfoSec_SecArch/PS/08/03" "/home/schnecki/Documents/UIBK/7.Semester/InfoSec_SecArch/PS/06/04/src" "/home/schnecki/Documents/UIBK/7.Semester/InfoSec_SecArch/PS/06/04" "/home/schnecki/Documents/UIBK/7.Semester/C++/project/textyTex/src/model/framework" "/home/schnecki/Documents/UIBK/7.Semester/C++/project/textyTex/src/model/exceptions" "/home/schnecki/Documents/UIBK/7.Semester/C++/project/textyTex/src/model" "/home/schnecki/Documents/UIBK/7.Semester/C++/project/textyTex/src" "/home/schnecki/Documents/UIBK/7.Semester/C++/project/textyTex" "/home/schnecki/Documents/UIBK/7.Semester/InfoSec_SecArch/PS/05/04/src" "/home/schnecki/Documents/UIBK/7.Semester/InfoSec_SecArch/PS/05/04")))
 '(flycheck-clang-include-path
   (quote
    ("/usr/include/gtkmm-3.0" "/usr/include/gdkmm-3.0" "/usr/include/glibmm-2.4" "/usr/include/gtkmm-3.0" "/usr/lib/gtkmm-3.0/include" "/usr/include/atkmm-1.6" "/usr/include/gtk-3.0/unix-print" "/usr/include/gdkmm-3.0" "/usr/lib/gdkmm-3.0/include" "/usr/include/giomm-2.4" "/usr/lib/giomm-2.4/include" "/usr/include/pangomm-1.4" "/usr/lib/pangomm-1.4/include" "/usr/include/glibmm-2.4" "/usr/lib/glibmm-2.4/include" "/usr/include/gtk-3.0" "/usr/include/at-spi2-atk/2.0" "/usr/include/at-spi-2.0" "/usr/include/dbus-1.0" "/usr/lib/dbus-1.0/include" "/usr/include/gtk-3.0" "/usr/include/gio-unix-2.0/" "/usr/include/cairo" "/usr/include/pango-1.0" "/usr/include/atk-1.0" "/usr/include/cairo" "/usr/include/cairomm-1.0" "/usr/lib/cairomm-1.0/include" "/usr/include/cairo" "/usr/include/pixman-1" "/usr/include/freetype2" "/usr/include/libpng16" "/usr/include/harfbuzz" "/usr/include/freetype2" "/usr/include/harfbuzz" "/usr/include/libdrm" "/usr/include/libpng16" "/usr/include/sigc++-2.0" "/usr/lib/sigc++-2.0/include" "/usr/include/gdk-pixbuf-2.0" "/usr/include/libpng16" "/usr/include/glib-2.0" "/usr/lib/glib-2.0/include")))
 '(flycheck-clang-includes (quote ("/usr/include/netdb.h")))
 '(flycheck-flake8-maximum-line-length 160)
 '(flymake-gui-warnings-enabled nil)
 '(frame-background-mode (quote dark))
 '(global-company-fuzzy-mode t nil (company-fuzzy))
 '(global-eclim-mode t)
 '(global-flycheck-mode t)
 '(global-undo-tree-mode t)
 '(gnus-topic-display-empty-topics nil)
 '(haskell-align-imports-pad-after-name t)
 '(haskell-ask-also-kill-buffers nil)
 '(haskell-doc-prettify-types t)
 '(haskell-font-lock-symbols nil)
 '(haskell-interactive-mode-collapse t)
 '(haskell-interactive-popup-errors nil)
 '(haskell-process-args-cabal-repl
   (quote
    ("--ghc-option=-ferror-spans" "--ghc-option=-fbreak-on-error")))
 '(haskell-process-args-ghci (quote ("-ferror-spans -fbreak-on-error")))
 '(haskell-process-args-stack-ghci nil)
 '(haskell-process-path-ghci "stack")
 '(haskell-process-type (quote stack-ghci))
 '(haskell-stylish-on-save t)
 '(helm-M-x-always-save-history t)
 '(helm-M-x-fuzzy-match t)
 '(helm-buffers-fuzzy-matching t)
 '(helm-case-fold-search (quote (quote smart)))
 '(helm-comp-read-case-fold-search (quote smart))
 '(helm-ff-file-name-history-use-recentf t)
 '(helm-ff-search-library-in-sexp t)
 '(helm-file-name-case-fold-search (quote smart))
 '(helm-flx-mode t)
 '(helm-fuzzy-matching-highlight-fn (quote helm-flx-fuzzy-highlight-match))
 '(helm-fuzzy-sort-fn (quote helm-flx-fuzzy-matching-sort))
 '(helm-input-idle-delay 0.1)
 '(helm-locate-case-fold-search (quote smart))
 '(helm-locate-command "locate %.0s %s")
 '(helm-mini-default-sources
   (quote
    (helm-source-buffers-list helm-source-recentf helm-source-buffer-not-found)))
 '(helm-mode t)
 '(helm-move-to-line-cycle-in-source t)
 '(helm-net-prefer-curl t)
 '(helm-scroll-amount 8)
 '(helm-split-window-inside-p t)
 '(help-at-pt-display-when-idle (quote (flymake-overlay)) nil (help-at-pt))
 '(help-at-pt-timer-delay 0.1)
 '(hindent-extra-args (quote ("--line-length" "180")))
 '(intero-extra-ghc-options (quote ("-ifay")))
 '(intero-extra-ghci-options nil)
 '(ivy-count-format "")
 '(ivy-mode t)
 '(ivy-use-virtual-buffers t)
 '(jde-compile-option-directory "./../classes")
 '(jde-compiler (quote ("javac")))
 '(jde-global-classpath (quote ("./../classes" "./../lib")))
 '(jde-jdk (quote ("1.8")))
 '(jde-jdk-registry (quote (("1.8" . "/usr/lib/jvm/default/"))))
 '(jde-sourcepath (quote ("./src/main" "./src/test")) t)
 '(kept-new-versions 5000)
 '(kill-ring-max 600)
 '(mc/always-run-for-all t)
 '(mpc-host "192.168.178.62")
 '(org-agenda-files (quote ("~/Documents/planning/")))
 '(org-agenda-skip-deadline-prewarning-if-scheduled 3)
 '(org-export-creator-string "")
 '(org-export-with-creator nil)
 '(org-file-apps
   (quote
    ((auto-mode . emacs)
     ("\\.mm\\'" . default)
     ("\\.x?html?\\'" . default)
     ("\\.pdf\\'" . "evince %s"))))
 '(org-html-creator-string "")
 '(org-latex-caption-above nil)
 '(org-latex-listings t)
 '(org-latex-prefer-user-labels t)
 '(org-latex-table-caption-above nil)
 '(org-use-sub-superscripts (quote {}))
 '(package-selected-packages
   (quote
    (company-quickhelp flyspell-lazy company-auctex company-bibtex company-fuzzy pabbrev ess color-theme-modern editorconfig editorconfig-generate wolfram-mode flycheck-pyflakes synonymous maude-mode erlang abs-mode hayoo undo-tree latex-pretty-symbols php-auto-yasnippets web-mode counsel helm-flx 0blayout browse-kill-ring yaml-mode gams-mode flycheck-elm elm-mode elm-yasnippets yasnippet-snippets company-statistics flycheck-elm elm-mode elm-yasnippets yasnippet-snippets company-statistics matlab-mode hamlet-mode thesaurus tuareg org-gcal flyspell-correct flyspell-correct-helm window-number w3m vc-darcs tex-smart-umlauts smart-mode-line shm shakespeare-mode request rainbow-mode rainbow-delimiters php-mode pager-default-keybindings ov orgtbl-ascii-plot org-plus-contrib org-cua-dwim org-ac multiple-cursors markdown-toc markdown-mode+ magit jedi javap-mode javadoc-lookup intero ido-ubiquitous ido-hacks ido-gnus htmlize hlint-refactor hindent helm-mode-manager helm-hoogle helm-hayoo helm-google helm-git-files helm-git helm-flycheck helm-dired-recent-dirs helm-c-yasnippet helm-bibtex header2 gnuplot-mode gnuplot ghci-completion fuzzy function-args flycheck-stack flycheck-ledger flycheck-haskell flycheck-google-cpplint flycheck-color-mode-line edbi ecb dired+ company-try-hard company-shell company-math company-c-headers change-inner cdlatex bookmark+ bison-mode backup-walker auto-dictionary auto-complete-clang auto-complete-c-headers auto-complete-auctex arduino-mode android-mode ace-window ace-jump-mode ace-jump-buffer ac-octave ac-math ac-ispell ac-etags ac-dabbrev ac-capf ac-c-headers)))
 '(safe-local-variable-values
   (quote
    ((intero-targets "simsim:lib" "simsim:exe:simsim-exe")
     (intero-targets "borl:lib" "borl:exe:gridworld" "borl:exe:gym" "borl:exe:multichain" "borl:exe:printer-mail" "borl:exe:queuing-system" "borl:exe:queuing-system-alt" "borl:exe:tensorflow-test" "borl:exe:three-states")
     (intero-targets "high-level-tensorflow:lib")
     (intero-targets "grenade:lib")
     (intero-targets "api-maker:lib")
     (intero-targets "borl:lib" "borl:exe:gridworld" "borl:exe:gym" "borl:exe:multichain" "borl:exe:printer-mail" "borl:exe:queuing-system" "borl:exe:tensorflow-test" "borl:exe:three-states")
     (intero-targets "borl:lib" "borl:exe:gridworld" "borl:exe:gridworld-hard" "borl:exe:gym" "borl:exe:multichain" "borl:exe:printer-mail" "borl:exe:tensorflow-test" "borl:exe:three-states")
     (intero-targets "borl-lp:lib")
     (intero-targets "borl-model-based:lib" "examples:exe:gridworld")
     (intero-targets "experimenter:lib" "experimenter:exe:dice" "experimenter:exe:dice-stateless" "experimenter:test:experimenter-test")
     (intero-targets "tensorflow-haskell-high-level-api:lib" "tensorflow-haskell-high-level-api:exe:feedforward")
     (intero-targets "tensorflow-haskell-high-level-api:lib" "tensorflow-haskell-high-level-api:exe:feedfoward")
     (TeX-mast . paper\.tex)
     (TeX-master . paper\.tex)
     (intero-targets "borl-model-based:lib" "borl-model-based:test:borl-model-based-test" "examples:exe:gridworld")
     (intero-targets "cms:lib" "cms:exe:cms")
     (intero-targets "simsim:lib" "simsim:exe:simsim-exe" "simsim:test:simsim-test")
     (intero-targets "cms:lib" "cms:exe:cms" "cms:test:test")
     (header-auto-update-enabled))))
 '(semanticdb-javap-classpath
   (quote
    ((concat
      (nth 0
           (split-string default-directory "src"))
      "./lib/")
     (concat
      (nth 0
           (split-string default-directory "src"))
      "./src/")
     (concat
      (nth 0
           (split-string default-directory "src"))
      "../Common/src/")
     (concat
      (nth 0
           (split-string default-directory "src"))
      "../Common/lib/"))))
 '(send-mail-function (quote smtpmail-send-it))
 '(setq max-specpdl-size t)
 '(size-indication-mode t)
 '(smtpmail-smtp-server "smtp.uibk.ac.at")
 '(smtpmail-smtp-service 587)
 '(solarized-contrast (quote high))
 '(tags-case-fold-search nil)
 '(tex-smart-umlauts-german-shortcuts nil)
 '(tool-bar-mode nil)
 '(tramp-default-method "ssh")
 '(undo-tree-visualizer-diff nil)
 '(undo-tree-visualizer-timestamps t)
 '(user-full-name your-full-name)
 '(user-mail-address your-mail-address)
 '(wolfram-path "/home/schnecki/Documents/Wolfram Mathematica/")
 '(xref-prompt-for-identifier t)
 '(yas-prompt-functions
   (quote
    (yas-ido-prompt yas-dropdown-prompt yas-completing-prompt yas-x-prompt yas-no-prompt))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-marker-1 ((t nil)))
 '(flymake-error ((((class color)) (:underline (:style wave :color "Red1")))))
 '(flymake-warning ((((class color)) (:underline (:style wave :color "Orange")))))
 '(fringe ((t nil)))
 '(magit-section-highlight ((t nil)))
 '(rainbow-delimiters-depth-1-face ((t (:foreground "red"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "magenta"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "cyan"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "brown"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "violet"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "green"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "tomato2"))))
 '(rainbow-delimiters-depth-9-face ((t (:foreground "orange"))))
 '(semantic-highlight-func-current-tag-face ((t (:box (:line-width 1 :color "grey75")))))
 '(undo-tree-visualizer-active-branch-face ((t (:foreground "black" :weight bold)))))

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)
(put 'narrow-to-region 'disabled nil)


;; Open gnus if it is loaded and user does not decline
(if (fboundp 'gnus)
    (if (y-or-n-p-with-timeout "Open Gnus (You got 5 seconds do decline)? " 5 t)
        (gnus)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init.el ends here

