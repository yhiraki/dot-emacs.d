;;; java_config.el ---
;;
;; Filename: java_config.el
;; Description:
;; Author: Manuel Schneckenreither
;; Maintainer:
;; Created: Mo Okt 14 18:17:43 2013 (+0200)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Di Apr  1 21:06:08 2014 (+0200)
;;           By: Manuel Schneckenreither
;;     Update #: 195
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
;;; Code:

;; (require 'semantic/db-javap)

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++ LOAD JAVA SPECIFIC SETTINGS ++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++++++ MINOR MODE +++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; Create and set tags table
(defun make-java-tags ()
  "This function reloads the tags by using the command 'make tags'."
  (interactive)
  (let ((dir (nth 0 (split-string default-directory "src"))))
    (setq esdir (replace-regexp-in-string " " "\\\\ " dir))
    (shell-command
     (concat "cd " esdir " && find . -name '*.java' -not -name '.#*' -print | etags - 1>/dev/null 2>/dev/null") nil)
    (visit-tags-table (concat dir "TAGS"))
    (start-process "delete_abrt_checker" nil "rm" "-f abrt_checker_* 1>/dev/null 2>/dev/null")
    ;; (shell-command "rm -f abrt_checker_* 1>/dev/null 2>/dev/null" nil)
    )
  )


;; MINOR MODE HOOK
(defun my/java-minor-mode ()
  "Minor mode hook for Java."

  ;; auto complete mode

  ;; (add-to-list 'ac-sources 'ac-source-abbrev)          ;; edited
  ;; (add-to-list 'ac-sources 'ac-source-css-property)
  ;; (add-to-list 'ac-sources 'ac-source-dictionary)
  ;; (add-to-list 'ac-sources 'ac-source-eclim)
  (add-to-list 'ac-sources 'ac-source-yasnippet)
  ;; (add-to-list 'ac-sources 'ac-source-symbols)
  ;; (add-to-list 'ac-sources 'ac-source-filename)
  ;; (add-to-list 'ac-sources 'ac-source-files-in-current-dir)
  ;; (add-to-list 'ac-sources 'ac-source-gtags)
  (add-to-list 'ac-sources 'ac-source-etags)
  ;; (add-to-list 'ac-sources 'ac-source-imenu)
  ;; (add-to-list 'ac-sources 'ac-source-semantic ;; slows down auto complete)
  ;; (add-to-list 'ac-sources 'ac-source-semantic-raw ;; slows down auto complete)
  ;; (add-to-list 'ac-sources 'ac-source-words-in-all-buffer)
  ;; (add-to-list 'ac-sources 'ac-source-words-in-buffer)
  (add-to-list 'ac-sources 'ac-source-words-in-same-mode-buffers)

  ;; auto complete (if it doesn't work try to disable flyspell mode!)
  (auto-complete-mode)

  ;; use programming flyspell mode
  (flyspell-prog-mode)


  ;; glasses mode
  ;; (glasses-mode t)

  ;; flymake init
  ;; (my-java-flymake-init)

  ;;FLYMAKE (ENHANCEMENTS)
  (local-set-key (kbd  "C-c ! n") 'my-flymake-show-next-error)
  (local-set-key (kbd "C-c ! p") 'my-flymake-show-prev-error)
  ;;ASOCIATE KEY FOR CURRENT ERROR POPUP/MINIBUFFER
  (local-set-key (kbd "C-c ! e") 'flymake:display-err-popup-for-current-line)

  ;; (local-set-key (kbd (concat prefix-command-key " e")) 'flymake:display-err-minibuf-for-current-line)
  (defvar-mode-local java-mode browse-url-browser-function #'w3m-browse-url)
  (defvar-mode-local jde-mode browse-url-browser-function #'w3m-browse-url)
  ;;
  ;; (set-variable browse-url-browser-function #'w3m-browse-url)

  (setq c-basic-offset 2)

  ;; CREATE AND SET TAGS FILE
  (add-hook 'after-save-hook 'make-java-tags nil t)
  )


(add-hook 'java-mode-hook 'my/java-minor-mode)
(add-hook 'jde-mode-hook 'my/java-minor-mode)

;; java tab width
;; (add-hook 'java-mode-hook (lambda () (setq c-basic-offset 2)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Java Compilation output - Make Emacs understand links
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(require 'compile)
(setq compilation-error-regexp-alist
  (append (list
     ;; works for jikes
     '("^\\s-*\\[[^]]*\\]\\s-*\\(.+\\):\\([0-9]+\\):\\([0-9]+\\):[0-9]+:[0-9]+:" 1 2 3)
     ;; works for javac
     '("^\\s-*\\[[^]]*\\]\\s-*\\(.+\\):\\([0-9]+\\):" 1 2))
  compilation-error-regexp-alist))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Java flymake
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(when (require 'flymake)
  (set-variable 'flymake-log-level 0)
  (setq flymake-start-syntax-check-on-newline nil)
  (setq flymake-no-changes-timeout 1)
  (add-hook 'java-mode-hook 'flymake-mode-on))


;; FLYMAKE TEMP FOLDER
(make-directory "~/.emacs.d/.tmp/flymake/" t)
(setq temporary-file-directory "~/.emacs.d/.tmp/flymake/")

(defun flymake-simple-java-cleanup ()
  (start-process "delete_flymake" nil "rm" "-rf ~/.emacs.d/.tmp/flymake/*")
  ;; (shell-command "rm " nil)
  )

;; ;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ;; ++++++++++++++ ENHANCEMENTS FOR DISPLAYING FLYMAKE ERRORS ++++++++++++
;; ;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(defun flymake:display-err-minibuf-for-current-line ()
  "Displays the error/warning for the current line in the minibuffer"
  (interactive)
  (let* ((line-no            (flymake-current-line-no))
         (line-err-info-list (nth 0 (flymake-find-err-info flymake-err-info line-no)))
         (count              (length line-err-info-list)))
    (while (> count 0)
      (when line-err-info-list
        (let* ((text       (flymake-ler-text (nth (1- count) line-err-info-list)))
               (line       (flymake-ler-line (nth (1- count) line-err-info-list))))
          (message "[%s] %s" line text)))
      (setq count (1- count))))
  )

(custom-set-variables
 '(help-at-pt-timer-delay 0.1)
 '(help-at-pt-display-when-idle '(flymake-overlay)))

(defun flymake:display-err-popup-for-current-line ()
  "Display a menu with errors/warnings for current line if it has errors and/or warnings."
  (interactive)
  (let* ((line-no            (flymake-current-line-no))
         (line-err-info-list (nth 0 (flymake-find-err-info flymake-err-info line-no)))
         (menu-data          (flymake-make-err-menu-data line-no line-err-info-list)))
    (if menu-data
        (popup-tip (mapconcat (lambda (e) (nth 0 e))
                              (nth 1 menu-data)
                              "\n")))
    )
  )


;; ------------------------------------------------------------------

;; SHOW NEXT ERROR FUNCTION
(defun my-flymake-show-next-error()
  (interactive)
  (flymake-goto-next-error)
  ;; (flymake:display-err-popup-for-current-line)
  (flymake-display-err-menu-for-current-line)
  )

;; SHOW PREV ERROR FUNCTION
(defun my-flymake-show-prev-error()
  (interactive)
  (flymake-goto-prev-error)
  (flymake:display-err-popup-for-current-line)
  ;;(flymake-display-err-menu-for-current-line)
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; java_config.el ends here
