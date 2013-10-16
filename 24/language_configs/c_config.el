(require 'cc-mode);

(load-file  (concat language_conf_folder "init-cc-compiler.el"))
(load-file  (concat language_conf_folder "init-cc-mode-syntax-check.el"))

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
(setq c-eldoc-includes   "pkg-config gtk+-2.0 --cflags` -I./ -I../ ")

;; C-MODE HOOK
;; (add-hook 'c-mode-common-hook (lambda () (flymake-mode 1)))
(setq auto-mode-alist (cons '("\.cl$" . c-mode) auto-mode-alist)) ;; OPENCL
(add-hook 'c-mode-hook 'c-turn-on-eldoc-mode)

;; C++ HOOK
;; (add-hook 'c++-mode-hook (lambda () (flymake-mode 1)))
(add-hook 'c++-mode-hook 'c++-turn-on-eldoc-mode)



;; C MODE
(if (eq 1 cedet)
    (defun my-c-mode-cedet-hook ()
      (add-to-list 'ac-sources 'ac-source-gtags)
      (add-to-list 'ac-sources 'ac-source-semantic)
      (local-set-key "." 'semantic-complete-self-insert)
      (local-set-key ">" 'semantic-complete-self-insert))

  ;; add hook
  (add-hook 'c-mode-common-hook 'my-c-mode-cedet-hook))
