

;;; emacs.el ---
;;
;; Filename: emacs.el
;; Status:
;; Author: Manuel Schneckenreither
;; Created: Tue Dec 11 00:43:14 2012 (+0100)
;; Version:
;; Last-Updated: Sa Nov  2 16:18:58 2013 (+0100)
;;           By: Manuel Schneckenreither
;;     Update #: 325
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

(load (concat folder "basics.el"))

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++ SPECIAL PACKAGES ++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; GLOBAL - tags
;; (load (concat package_conf_folder "global_config.el"))
;; CEDET - semantic, EDE, etc. // TODO CEHCK COMPILATION
;; CEDET gets loaded in ~/.emacs
(load (concat package_conf_folder "cedet_config.el"))
;; ECB - windows showing help
(load (concat package_conf_folder "ecb_config.el"))
;; Eldoc config
(load (concat package_conf_folder "eldoc_config.el"))
;; FLYCHECK -- automatic syntax checking on-the-fly
(load (concat package_conf_folder "flycheck_config.el"))
;; FLYSPELL -- automatic spell checking on-the-fly
(load (concat package_conf_folder "flyspell_config.el"))
;; HEADER 2 - Enter a header in the files
(load (concat package_conf_folder "header2_config.el"))
;; IDO - minibuffer helper
(load (concat package_conf_folder "ido_config.el"))
;; MULTIPLE CURSORS - use multiple cursors to edit the buffers
(load (concat package_conf_folder "multiple_cursors_config.el"))
;; THESAURUS - choose synonym and replace
(load (concat package_conf_folder "thesaurus_config.el"))
;; WINDOW NUMBER MODE - change windows by C-x C-j [NUMBER] or  META-[NUMBER]
(load (concat package_conf_folder "window-number_config.el"))
;; YASNIPPET - snippets easily handled
(load (concat package_conf_folder "yasnippet_config.el"))
;; JDEE Mode
(load (concat package_conf_folder "jdee_config.el"))
;; COLUMN MAKER -- mark columns
(load (concat package_conf_folder "org_mode_config.el"))
;; AUTO COMPLETE - completion - You should not disable this, you know what you
;; are doing
(load (concat package_conf_folder "auto_complete_config.el"))
;; COLUMN MAKER -- mark columns
(load (concat package_conf_folder "whitespace_config.el"))
;; MAKE BACKUPS
(load (concat package_conf_folder "backup_each_save_config.el"))
;; MAGIT - git for emacs
(load (concat package_conf_folder "magit_config.el"))
;; DIRED - file mangement for emacs
(load (concat package_conf_folder "dired_config.el"))
;; PAGER -- better scrolling
(load (concat package_conf_folder "pager_config.el"))


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++ LOAD LANGUAGE SPECIFIC SETTINGS ++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; C, C++
;; (load-file (concat language_conf_folder "c_config.el"))
(load-file (concat language_conf_folder "haskell_config.el"))
(load-file (concat language_conf_folder "java_config.el"))
(load-file (concat language_conf_folder "emacs_lisp_config.el"))
;; (load-file (concat language_conf_folder "ocaml_config.el"))
(load-file (concat language_conf_folder "makefile_config.el"))
(load-file (concat language_conf_folder "latex_config.el"))

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++ LOAD KEYBINDINGS ++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(load (concat folder "basic_keys.el"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; emacs.el ends here
