
(load-file (concat package_folder "tex_texify/tex_texify.el"))



;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++ LATEX CONFIG ++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil)
(setq preview-auto-cache-preamble nil)
(setq TeX-PDF-mode t)

;; (require 'flymake)

;; (defun flymake-get-tex-args (file-name)
;;   (list "pdflatex"
;;         (list "-file-line-error" "-draftmode" "-interaction=nonstopmode" file-name)))

;; (add-hook 'LaTeX-mode-hook 'flymake-mode)

(setq ispell-program-name "ispell") ; could be ispell as well, depending on your preferences
(setq ispell-dictionary "english") ; this can obviously be set to any language your spell-checking program supports


(require 'tex-site)
(autoload 'reftex-mode "reftex" "RefTeX Minor Mode" t)
(autoload 'turn-on-reftex "reftex" "RefTeX Minor Mode" nil)
(autoload 'reftex-citation "reftex-cite" "Make citation" nil)
(autoload 'reftex-index-phrase-mode "reftex-index" "Phrase Mode" t)
(add-hook 'latex-mode-hook 'turn-on-reftex) ; with Emacs latex mode
;; (add-hook 'reftex-load-hook 'imenu-add-menubar-index)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)

(setq LaTeX-eqnarray-label "eq"
      LaTeX-equation-label "eq"
      LaTeX-figure-label "fig"
      LaTeX-table-label "tab"
      LaTeX-myChapter-label "chap"
      TeX-auto-save t
      TeX-newline-function 'reindent-then-newline-and-indent
      TeX-parse-self t
      TeX-style-path
      '("style/" "auto/"
        "/usr/share/emacs21/site-lisp/auctex/style/"
        "/var/lib/auctex/emacs21/"
        "/usr/local/share/emacs/site-lisp/auctex/style/")
      LaTeX-section-hook
      '(LaTeX-section-heading
        LaTeX-section-title
        LaTeX-section-toc
        LaTeX-section-section
        LaTeX-section-label))


;; always update pdf in docView // better use evince !
;; (add-hook 'doc-view-mode-hook 'auto-revert-mode)


;; set tex master by guessing
;;; Code:
(defun guess-TeX-master (filename)
  "Guess the master file for FILENAME from currently open .tex files."
  (let ((candidate nil)
        (filename (file-name-nondirectory filename)))
    (save-excursion
      (dolist (buffer (buffer-list))
        (with-current-buffer buffer
          (let ((name (buffer-name))
                (file buffer-file-name))
            (if (and file (string-match "\\.tex$" file))
                (progn
                  (goto-char (point-min))
                  (if (re-search-forward (concat "\\\\input{" filename "}") nil t)
                      (setq candidate file))
                  (if (re-search-forward (concat "\\\\include{" (file-name-sans-extension filename) "}") nil t)
                      (setq candidate file))))))))
    (if candidate
        (message "TeX master document: %s" (file-name-nondirectory candidate)))
    candidate))


(add-hook 'LaTeX-mode-hook
          (lambda()
            (TeX-PDF-mode t)
            (setq TeX-master (guess-TeX-master (buffer-file-name)))
            (flyspell-mode)
            (flyspell-buffer)
            ;; (turn-on-outline-minor-mode)
            ;; (define-key LaTeX-mode-map (kbd "M-.") 'TeX-complete-symbol)
            ))

;; sync between evince and emacs auctex
(setq TeX-source-correlate-mode t)

;; start correlate server
(setq TeX-source-correlate-start-server t)


;; compile and show latex in one command
(defun compile-show-latex ()
  "Comile latex and show in evince"
  (interactive)
  (TeX-texify)
  ;; (async-shell-command "rm -rf *.aux *.bbl *.log *.blg *.toc *.out *.dvi *.backup *.exl *.exls *.ps 1>/dev/null 2>/dev/null" t)
  (TeX-command "View" 'TeX-active-master 0))



(setq TeX-view-program-selection
      '((output-html "xdg-open")
        (output-pdf "Evince")
        (output-dvi "Evince")))


;; KEYBINDINGSp
;; (add-hook 'LaTeX-mode-hook (lambda () (local-set-key (kbd "C-c C-SPC") 'compile-show-latex)))


;; (defun turn-on-outline-minor-mode ()
;;  (outline-minor-mode 1))
;; (setq outline-minor-mode-prefix "\C-c \C-o") ; Or something else



(defun my-latex (action)
  (interactive)
  (if (buffer-modified-p) (save-buffer))
  (let ((f1 (current-frame-configuration))
        (retcode (shell-command (concat "~/bin/my-latex " action " " buffer-file-name))))
    (if (= retcode 0) (set-frame-configuration f1))))

(global-set-key  (kbd "<f8>") '(lambda () (interactive) (my-latex "preview")))
(global-set-key (kbd "C-c C-SPC") '(lambda () (interactive) (my-latex "create")))
