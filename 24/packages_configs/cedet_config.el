;;; cedet_config.el ---
;;
;; Filename: cedet_config.el
;; Description:
;; Author: Manuel Schneckenreither
;; Maintainer:
;; Created: So Okt 13 11:05:43 2013 (+0200)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Di Jan 21 20:55:32 2014 (+0100)
;;           By: Manuel Schneckenreither
;;     Update #: 33
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
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++ BUILD CEDET  ++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; (defun byte-compile-cedet ()
;;   (load (concat package-folder "cedet-1.1/cedet-build.el"))
;;   (cedet-build-in-default-emacs)
;;   (message "CEDET BUILT"))


;; ;; DO ONLY IF NOT BUILT YET
;; (if (not (file-exists-p (concat package-folder
;;                                 "cedet-1.1/common/cedet.elc")))
;;     (byte-compile-cedet))


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++ CEDET CONFIG ++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


;; Load CEDET.
;; IMPORTANT: Tou must place this *before* any CEDET component (including
;; EIEIO) gets activated by another package (Gnus, auth-source, ...).
(setq cedet-root-path (file-name-as-directory (concat package-folder "cedet/")))
(load-file (concat cedet-root-path "cedet-devel-load.el"))
(add-to-list 'load-path (concat cedet-root-path "contrib"))

;; select which submodes we want to activate
(add-to-list 'semantic-default-submodes 'global-semantic-mru-bookmark-mode)
(add-to-list 'semantic-default-submodes 'global-semanticdb-minor-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-scheduler-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-stickyfunc-mode)
(add-to-list 'semantic-default-submodes 'global-cedet-m3-minor-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-highlight-func-mode)
(add-to-list 'semantic-default-submodes 'global-semanticdb-minor-mode)

;; Activate semantic
(semantic-mode 1)

;; load contrib library
(require 'eassist)

;; customisation of modes
(defun my/cedet-hook ()
  (local-set-key [(control return)] 'semantic-ia-complete-symbol-menu)
  (local-set-key "\C-c?" 'semantic-ia-complete-symbol)
  (local-set-key "\C-c>" 'semantic-complete-analyze-inline)
  (local-set-key "\C-c=" 'semantic-decoration-include-visit)
  (local-set-key "\C-cj" 'semantic-ia-fast-jump)
  (local-set-key "\C-cq" 'semantic-ia-show-doc)
  (local-set-key "\C-cs" 'semantic-ia-show-summary)
  (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)
  )

(add-hook 'c-mode-common-hook 'my/cedet-hook)
(add-hook 'lisp-mode-hook 'my/cedet-hook)
(add-hook 'scheme-mode-hook 'my/cedet-hook)
(add-hook 'emacs-lisp-mode-hook 'my/cedet-hook)
(add-hook 'erlang-mode-hook 'my/cedet-hook)

(defun my/c-mode-cedet-hook ()
  (local-set-key "\C-ct" 'eassist-switch-h-cpp)
  (local-set-key "\C-xt" 'eassist-switch-h-cpp)
  (local-set-key "\C-ce" 'eassist-list-methods)
  (local-set-key "\C-c\C-r" 'semantic-symref)
  )

(add-hook 'c-mode-common-hook 'my/c-mode-cedet-hook)

(semanticdb-enable-gnu-global-databases 'c-mode t)
(semanticdb-enable-gnu-global-databases 'c++-mode t)

(when (cedet-ectag-version-check t)
(semantic-load-enable-primary-ectags-support))

;; SRecode
(global-srecode-minor-mode 1)

;; EDE
(global-ede-mode 1)
(ede-enable-generic-projects)


;; Setup JAVA....
(require 'cedet-java)


;; ;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ;; +++++++++++++++++++++++++++ GLOBAL KEYS ++++++++++++++++++++++++++++++
;; ;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; (global-set-key [(control return)] 'semantic-ia-complete-symbol)
;; (global-set-key "\C-c?" 'semantic-ia-complete-symbol-menu)
;; (global-set-key "\C-c>" 'semantic-complete-analyze-inline)
;; (global-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)

;; ;; bind eassist-list-message
;; (global-set-key (kbd (concat prefix-command-key " h") 'semantic-analyze-proto-impl-toggle)
;; (global-set-key (kbd (concat prefix-command-key " i") 'semantic-ia-fast-jump)
;; (global-set-key (kbd (concat prefix-command-key " o") 'semantic-mrub-switch-tags)
;; (global-set-key (kbd (concat prefix-command-key " l") 'semantic-decoration-include-visit)

;; (global-set-key (kbd (concat prefix-command-key " f") 'eassist-list-methods)
;; (global-set-key (kbd "C-c s") 'eassist-switch-h-cpp )
;; (global-set-key (kbd "C-c u") 'speedbar-update-contents)
;; (global-set-key (kbd "C-c f") 'speedbar-get-focus)

;; (global-set-key (kbd (concat prefix-command-key " d") 'semantic-ia-show-doc)
;; (global-set-key (kbd (concat prefix-command-key " s") 'semantic-ia-show-summary)
;; (global-set-key (kbd (concat prefix-command-key " <left>") 'semantic-tag-folding-fold-block)
;; (global-set-key (kbd (concat prefix-command-key " <right>") 'semantic-tag-folding-show-block)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; cedet_config.el ends here
