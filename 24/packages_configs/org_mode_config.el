

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

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++++++ MINOR MODE +++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


;; MINOR MODE HOOK
(defun my/org-minor-mode ()
  "Minor mode hook for Org."

  )

(add-hook 'org-mode-hook 'my/org-minor-mode)


(setq org-startup-indented t)


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++++ DEFAULT KEYS +++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
