

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++ MAGIT KEYS ++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


;; pull short
(global-set-key (kbd (concat prefix-command-key " g p"))
                'magit-pull)

;; pull long
;; (global-set-key (kbd (concat prefix-command-key " g p u l"))
;;                 'magit-pull)

;; push short
;; (global-set-key (kbd (concat prefix-command-key " g h"))
;;                 'magit-push)

;; push long
;; (global-set-key (kbd (concat prefix-command-key " g p u s"))
;;                 'magit-push)

;; git log
(global-set-key (kbd (concat prefix-command-key " g l"))
                'magit-log)

;; git status
(global-set-key (kbd (concat prefix-command-key " g s"))
                'magit-status)
