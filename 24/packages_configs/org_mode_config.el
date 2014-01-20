

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++ ORG CONFIG ++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(org-babel-do-load-languages
    'org-babel-load-languages
    '((gnuplot . t)))

;; persistent clocking
(setq org-clock-persisnt 'history)
(org-clock-persistence-insinuate)

;; personal agendas
(setq org-agenda-custom-commands
      '(
        ("y" agenda*)
        ("w" todo "WAITING")
        ("W" todo-tree "WAITING")
        ("d" "Daily Action List"
         ((agenda "")
          (org-agenda-ndays 1)
          (org-agenda-sorting-strategy
           (quote ((agenda time-up priority-down tag-up) )))
          (org-deadline-warning-days 0)))
        ("v" tags-todo "+BAC")
        ))

;; do not show prewarnings when also scheduled, but x days before the deadline
(setq org-agenda-skip-deadline-prewarning-if-scheduled 3)

;; format string used when creating CLOCKSUM lines and when generating a
;; time duration (avoid showing days)
(setq org-time-clocksum-format
      '(:hours "%d" :require-hours t :minutes ":%02d" :require-minutes t))

;; requiore export to taksjuggler
(require 'ox-taskjuggler)


;; require for export to pdf
;; (require 'ox-groff)

;; easy follow links
(setq org-return-follows-link t)

;; open text files in org mode
(add-to-list 'auto-mode-alist '("\\.txt$" . org-mode))

;; open unknown files in org mode
(setq-default major-mode 'org-mode)


;; Insert source code
(defun org-insert-src-block (src-code-type)
  "Insert a `SRC-CODE-TYPE' type source code block in org-mode."
  (interactive
   (let ((src-code-types
          '("emacs-lisp" "python" "C" "sh" "jde" "js" "clojure" "C++" "css"
            "calc" "asymptote" "dot" "gnuplot" "ledger" "lilypond" "mscgen"
            "octave" "oz" "plantuml" "R" "sass" "screen" "sql" "awk" "ditaa"
            "haskell" "latex" "lisp" "matlab" "ocaml" "org" "perl" "ruby"
            "scheme" "sqlite")))
     (list (ido-completing-read "Source code type: " src-code-types))))
  (progn
    (newline-and-indent)
    (insert (format "#+BEGIN_SRC %s\n" src-code-type))
    (newline-and-indent)
    (insert "#+END_SRC\n")
    (previous-line 2)
    (org-edit-src-code)
    ))

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++++ DRAW DIAGRAMS ++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


(setq org-ditaa-jar-path (concat package_folder "java_files/ditaa0_9.jar"))
(setq org-plantuml-jar-path (concat package_folder "java_files/plantuml.jar"))

(add-hook 'org-babel-after-execute-hook 'bh/display-inline-images 'append)


; Make babel results blocks lowercase
(setq org-babel-results-keyword "results")

(defun bh/display-inline-images ()
  (condition-case nil
      (org-display-inline-images)
    (error nil)))

(org-babel-do-load-languages
 (quote org-babel-load-languages)
 (quote ((emacs-lisp . t)
         (dot . t)
         (ditaa . t)
         (R . t)
         (python . t)
         (ruby . t)
         (gnuplot . t)
         (clojure . t)
         (sh . t)
         (ledger . t)
         (org . t)
         (plantuml . t)
         (latex . t))))

; Do not prompt to confirm evaluation
; This may be dangerous - make sure you understand the consequences
; of setting this -- see the docstring for details
(setq org-confirm-babel-evaluate nil)

; Use fundamental mode when editing plantuml blocks with C-c '
(add-to-list 'org-src-lang-modes (quote ("plantuml" . fundamental)))


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++++++ MINOR MODE +++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


;; MINOR MODE HOOK
(defun my/org-minor-mode ()
  "Minor mode hook for Org."

  (local-set-key (kbd "C-c C-x s") 'org-insert-src-block)

  )

(add-hook 'org-mode-hook 'my/org-minor-mode)


(setq org-startup-indented t)


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++++ DEFAULT KEYS +++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
