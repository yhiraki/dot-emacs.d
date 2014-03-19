;;; emacs.el ---
;;
;; Filename: emacs.el
;; Status:
;; Author: Manuel Schneckenreither
;; Created: Tue Dec 11 00:43:14 2012 (+0100)
;; Version:
;; Last-Updated: Mi Mär 19 21:52:55 2014 (+0100)
;;           By: Manuel Schneckenreither
;;     Update #: 370
;; URL:
;; Description:
;;
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++ BASICS ++++++++++++++++++++++++++++++++
;; ++++++++++++++ which means no extra package needed +++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(load (concat load-folder "basics.el"))
;; custom themes
(load (concat load-folder "custom_themes.el"))

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++ SPECIAL PACKAGES ++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; WINNER MODE - undo window configurations (needs to be done before ECB)
(load (concat package-conf-folder "winner_mode_config.el"))
;; CEDET - semantic, EDE, etc. (needs to be done pretty early!)
(load (concat package-conf-folder "cedet_config.el"))
;; ECB - windows showing help
(load (concat package-conf-folder "ecb_config.el"))
;; Eldoc config
(load (concat package-conf-folder "eldoc_config.el"))
;; FLYCHECK -- automatic syntax checking on-the-fly
(load (concat package-conf-folder "flycheck_config.el"))
;; FLYSPELL -- automatic spell checking on-the-fly
(load (concat package-conf-folder "flyspell_config.el"))
;; HEADER 2 - Enter a header in the files
(load (concat package-conf-folder "header2_config.el"))
;; IDO - minibuffer helper
(load (concat package-conf-folder "ido_config.el"))
;; MULTIPLE CURSORS - use multiple cursors to edit the buffers
(load (concat package-conf-folder "multiple_cursors_config.el"))
;; THESAURUS - choose synonym and replace
(load (concat package-conf-folder "thesaurus_config.el"))
;; WINDOW NUMBER MODE - change windows by C-x C-j [NUMBER] or  META-[NUMBER]
(load (concat package-conf-folder "window-number_config.el"))
;; YASNIPPET - snippets easily handled
(load (concat package-conf-folder "yasnippet_config.el"))
;; JDEE Mode
(load (concat package-conf-folder "jdee_config.el"))
;; ORG Mode
(load (concat package-conf-folder "org_mode_config.el"))
;; AUTO COMPLETE - completion - You should not disable this, you know what you
;; are doing
(load (concat package-conf-folder "auto_complete_config.el"))
;; WHITESPACE MODE -- mark 80'th+ columns
(load (concat package-conf-folder "whitespace_config.el"))
;; MAKE BACKUPS
(load (concat package-conf-folder "backup_each_save_config.el"))
;; MAGIT - git for emacs
(load (concat package-conf-folder "magit_config.el"))
;; DIRED - file mangement for emacs
(load (concat package-conf-folder "dired_config.el"))
;; PAGER -- better scrolling
(load (concat package-conf-folder "pager_config.el"))
;; RAINBOW DELIMITERS - show parenthesis in different colors
(load (concat package-conf-folder "rainbow_del_config.el"))
;; RAINBOW MODE - background of color names in specified color
(load (concat package-conf-folder "rainbow_mode_config.el"))
;; POWERLINE - better modline
(load (concat package-conf-folder "powerline_config.el"))
;; ANDROID MODE
;; (load (concat package-conf-folder "android_mode_config.el"))
;; BBDB - Address-Book Management (load before GNUS)
(load (concat package-conf-folder "bbdb_config.el"))
;; GNUS - Newsreader and Email Client
(load (concat package-conf-folder "gnus_config.el"))
;; CUA - use rectangle selections
(load (concat package-conf-folder "cua_config.el"))
;; BOOKMARKS+ - bookmark extendsion
(load (concat package-conf-folder "bmkp_config.el"))
;; GHC MODE - listes as GHC ins init file
(load (concat package-conf-folder "ghc_mode_config.el"))

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++ LOAD LANGUAGE SPECIFIC SETTINGS ++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(load-file (concat language-conf-folder "c_config.el"))
(load-file (concat language-conf-folder "haskell_config.el"))
(load-file (concat language-conf-folder "java_config.el"))
(load-file (concat language-conf-folder "emacs_lisp_config.el"))
(load-file (concat language-conf-folder "ocaml_config.el"))
(load-file (concat language-conf-folder "makefile_config.el"))
(load-file (concat language-conf-folder "latex_config.el"))

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++ LOAD KEYBINDINGS ++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(load (concat load-folder "basic_keys.el"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; emacs.el ends here


