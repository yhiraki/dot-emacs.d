

;; reuse the same buffer

(put 'dired-find-alternate-file 'disabled nil)

;; When moving to parent directory by `^´, Dired by default creates a
;; new buffer for each movement up. The following rebinds `^´ to use
;; the same buffer.


(add-hook 'dired-mode-hook
 (lambda ()
  (define-key dired-mode-map (kbd "^")
    (lambda () (interactive) (find-alternate-file "..")))
  ; was dired-up-directory
 ))
