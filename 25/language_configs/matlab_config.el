
;; associate .m files with matlab
(setq auto-mode-alist
      (cons '("\\.m$" . matlab-mode) auto-mode-alist))


(defun make-matlab-tags ()
  "This function reloads the tags by using the command 'make tags'."
  (interactive)
  (let ((dir (nth 0 (if (string-match "app/" default-directory)
                        (split-string default-directory "app")
                      (split-string default-directory "src")))))
    (setq esdir (replace-regexp-in-string " " "\\\\ " dir))
    ;; (message esdir)
    (setq tagslst '("."))
    (if (file-exists-p (concat esdir "src")) (add-to-list 'tagslst "src"))
    (if (file-exists-p (concat esdir "app")) (add-to-list 'tagslst "app"))
    (setq dirs (mapconcat 'identity tagslst " "))
    ;; (message dirs)
    (shell-command
     (concat "cd " esdir
             ;; " && hasktags --ignore-close-implementation -e --cache . 2>/dev/null 1>/dev/null") nil)
             " && sh mtags.sh "
             ;; dirs ;; " 2>/dev/null 1>/dev/null"
             ) nil)
    (visit-tags-table (concat dir "TAGS")))
  )


(defun my/matlab-minor-mode ()
  (add-hook 'after-save-hook 'make-matlab-tags nil t)
)


(add-hook 'matlab-mode-hook 'my/matlab-minor-mode)


