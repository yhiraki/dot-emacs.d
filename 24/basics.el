;; basics.el ---
;;
;; Filename: basics.el
;; Status:
;; Author: Manuel Schneckenreither
;; Created: Mon Dec 10 22:51:09 2012 (+0100)
;; Version:
;; Last-Updated: Mi Jan  8 20:49:27 2014 (+0100)
;;           By: Manuel Schneckenreither
;;     Update #: 541
;; URL:
;; Description:
;;    Basic configuration for emacs. In here are all configs of
;;    components which do not need any packages or languages,
;;    but come with emacs.
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++ DESKTOP SESSIONS +++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; DESKTOP - Save and restore open buffers, point, mark, histories, other variables
(desktop-save-mode 1)

(defun my-desktop-save ()
  (interactive)
  ;; Don't call desktop-save-in-desktop-dir, as it prints a message.
  (if (eq (desktop-owner) (emacs-pid))
      (desktop-save desktop-dirname)))

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++ COMPILATION +++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; SET RECOMPILE FUNCTION
(setq compilation-last-buffer nil)
(defun compile-again (pfx)
  (interactive "p")
  (if (and (eq pfx 1)
           compilation-last-buffer)
      (progn
        (set-buffer compilation-last-buffer)
        (revert-buffer t t))
    (call-interactively 'compile)))

;; CLOSE THE COMPILATION WINDOW IF THERE WAS NO ERROR AT ALL.
(defun compilation-exit-autoclose (status code msg)
  ;; If M-x compile exists with a 0
  (when (and (eq status 'exit) (zerop code))
    ;; then bury the *compilation* buffer, so that C-x b doesn't go there
    (bury-buffer)
    ;; and delete the *compilation* window
    (replace-buffer-in-windows "*compilation*")
    (other-window 1)
    (eshell)
    (return)) ;; open compilation window
  ;; Always return the anticipated result of compilation-exit-message-function
  (cons msg code))

;; SPECIFY FUNCTION
(setq compilation-exit-message-function 'compilation-exit-autoclose)


;; get the makefile above
(defun get-above-makefile ()
  (loop as d = default-directory then (expand-file-name
       ".." d) if (file-exists-p (expand-file-name "Makefile" d)) return
       d))


;; COMPILE CLOSES MAKEFILE
(defun compile-closest-Makefile ()
  (interactive)
  (compile
   (concat "make -C " (loop as d = default-directory then (expand-file-name
       ".." d) if (file-exists-p (expand-file-name "Makefile" d)) return
       d))))

;; bind compiling with get-above-makefile to f5
(global-set-key [f5] 'compile-closest-Makefile)


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++ YES AND NO PROMPTS ++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; MAKE YES NO PROMTS TO Y N PROMTS
(defalias 'yes-or-no-p 'y-or-n-p)

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++ DISPLAY LINE NUMBERS +++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(require 'linum)
(global-linum-mode) ;; Turn on line numbers
(setq linum-format "%3d|")

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++ HIGHLIGHT MODE +++++++++++++++++++++++++++=
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(defun highlight-changes-remove-after-save ()
  "Remove previous changes after save."
  (make-local-variable 'after-save-hook)
  (add-hook 'before-save-hook
            (lambda ()
              (highlight-changes-remove-highlight (point-min) (point-max)))))

;; (global-highlight-changes-mode t)
  ;; (setq highlight-changes-remove-highlight t)
;; (add-hook 'after-save-hook 'highlight-changes-remove-after-save)

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++ TAB SETTINGS ++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; TAB WIDTH
(setq-default tab-width 4) ; or any other preferred value
(setq cua-auto-tabify-rectangles nil)

;; SMART TABS
(defadvice align (around smart-tabs activate)
  (let ((indent-tabs-mode nil)) ad-do-it))

(defadvice align-regexp (around smart-tabs activate)
  (let ((indent-tabs-mode nil)) ad-do-it))

(defadvice indent-relative (around smart-tabs activate)
  (let ((indent-tabs-mode nil)) ad-do-it))

(defadvice indent-according-to-mode (around smart-tabs activate)
  (let ((indent-tabs-mode indent-tabs-mode))
    (if (memq indent-line-function
              '(indent-relative
                indent-relative-maybe))
        (setq indent-tabs-mode nil))
    ad-do-it))

(defmacro smart-tabs-advice (function offset)
  `(progn
     (defvaralias ',offset 'tab-width)
     (defadvice ,function (around smart-tabs activate)
       (cond
        (indent-tabs-mode
         (save-excursion
           (beginning-of-line)
           (while (looking-at "\t*\\( +\\)\t+")
             (replace-match "" nil nil nil 1)))
         (setq tab-width tab-width)
         (let ((tab-width fill-column)
               (,offset fill-column)
               (wstart (window-start)))
           (unwind-protect
               (progn ad-do-it)
             (set-window-start (selected-window) wstart))))
        (t
         ad-do-it)))))

;; (smart-tabs-advice c-indent-line c-basic-offset)
;; (smart-tabs-advice c-indent-region c-basic-offset)

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++++ INDENT BUFFER ++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; format whole buffer
(defun iwb ()
  "indent whole buffer"
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max)))

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++ APOSTROPHES AROUND REGION ++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(defun region-insert-char (p1 p2 beg end)
  (save-excursion
    (goto-char p2)
    (insert end)
    (goto-char p1)
    (insert beg)
    )
  (forward-char))

(defun insert-apostrophes (posBegin posEnd)
  "Insert apostrophes at beginning and end of region."
  (interactive "r")
  (region-insert-char posBegin posEnd "\"" "\"")
  )

(defun insert-parenthesis (posBegin posEnd)
  "Insert parenthesis at beginning and end of region."
  (interactive "r")
  (region-insert-char posBegin posEnd "(" ")")
  )

(defun insert-brackets (posBegin posEnd)
  "Insert brackets at beginning and end of region."
  (interactive "r")
  (region-insert-char posBegin posEnd "[" "]")
  )

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++ TAGS INFORMATION ++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;;; View tags other window
(defun view-tag-other-window (tagname &optional next-p regexp-p)
  "Same as `find-tag-other-window' but doesn't move the point"
  (interactive (find-tag-interactive "View tag other window: "))
  (let ((window (get-buffer-window)))
    (find-tag-other-window tagname next-p regexp-p)
    (recenter 10)
    (select-window window)))


;; RECREATE TAGS
(defun recreate-tags ()
  "This function reloads the tags by using the command 'make tags'"
  (interactive)
  (with-temp-buffer
    (async-shell-command "make tags 1>/dev/null 2>/dev/null" t)
    ))

;; FIND CLOSEST TAGS FILE
;; (defun* get-closest-pathname (&optional (file "TAGS"))
;;   "Determine the pathname of the first instance of FILE starting from the current directory towards root.
;; This may not do the correct thing in presence of links. If it does not find FILE, then it shall return the name
;; of FILE in the current directory, suitable for creation"
;;   (let ((root (expand-file-name "/"))) the win32 builds should translate this correctly
;;     (expand-file-name file
;;                       (loop
;;                        for d = default-directory then (expand-file-name ".." d)
;;                        if (file-exists-p (expand-file-name file d))
;;                        return d
;;                        if (equal d root)
;;                        return nil))))

;; (defun set-visit-tags-table ()
;;   (interactive)
;;   (if (not (equal tags-file-name nil))
;;       (if (not (equal nil (get-closest-pathname "TAGS")))
;;           (setq tags-file-name (get-closest-pathname "TAGS")))))

;; (if (eq 1 use_tags)
;;     (add-hook 'after-save-hook 'set-visit-tags-table))

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++ CONFIGURE IN MINIBUFFER INFO ++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
(display-time-mode t)
(column-number-mode t)
(line-number-mode t)
(size-indication-mode t)


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++ BACKUP INFO +++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; create the autosave dir if necessary, since emacs won't.
(make-directory "~/.emacs.d/.tmp/autosaves/" t)
(make-directory "~/.emacs.d/.tmp/backups/" t)

;; Put autosave files (ie #foo#) and backup files (ie foo~) in ~/.emacs.d/.
(custom-set-variables
 '(auto-save-file-name-transforms '((".*" "~/.emacs.d/.tmp/autosaves/\\1" t)))
 '(backup-directory-alist '((".*" . "~/.emacs.d/.tmp/backups/"))))

;; (setq backup-directory-alist `(("." . "~/.saves")))
;; (setq backup-by-copying t)
;; (setq delete-old-versions nil
;;       kept-new-versions 10000
;;       kept-old-versions 1024
;;       version-control t)


(setq make-backup-files t               ; backup of a file the first time it is saved.
      backup-by-copying t               ; don't clobber symlinks
      version-control t                 ; version numbers for backup files
      delete-old-versions t             ; delete excess backup files silently
      delete-by-moving-to-trash t
      kept-old-versions 1024            ; oldest versions to keep when a new numbered backup is made (default: 2)
      kept-new-versions 10000           ; newest versions to keep when a new numbered backup is made (default: 2)
      auto-save-default t               ; auto-save every buffer that visits a file
      auto-save-timeout 20              ; number of seconds idle time before auto-save (default: 30)
      auto-save-interval 200            ; number of keystrokes between auto-saves (default: 300)
      )

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++ CLIPBOARD TRACKING++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(setq x-select-enable-clipboard t)

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++ FULLSCREEN ++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(defvar my-fullscreen-p t "Check if fullscreen is on or off")

(defun my-non-fullscreen ()
  (interactive)
  (if (fboundp 'w32-send-sys-command)
      ;; WM_SYSCOMMAND restore #xf120
      (w32-send-sys-command 61728)
    (progn (set-frame-parameter nil 'width 82)
           (set-frame-parameter nil 'fullscreen 'fullheight)
           (menu-bar-mode 1))))

(defun my-fullscreen ()
  (interactive)
  (if (fboundp 'w32-send-sys-command)
      ;; WM_SYSCOMMAND maximaze #xf030
      (w32-send-sys-command 61488)
    (set-frame-parameter nil 'fullscreen 'fullboth)
    (menu-bar-mode 0)))

(defun my-toggle-fullscreen ()
  (interactive)
  (setq my-fullscreen-p (not my-fullscreen-p))
  (if my-fullscreen-p
      (my-non-fullscreen)
    (my-fullscreen)))

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++ STOP ASKING EXISTING PROCESS EXISTS STUFF +++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(defadvice save-buffers-kill-emacs (around no-query-kill-emacs activate)
  "Prevent annoying \"Active processes exist\" query when you quit Emacs."
  (flet ((process-list ())) ad-do-it))

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++ AUTOMATICALLY WRAP LONG LINES +++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; set the wrapping length to column x
(setq fill-column 80)

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++ JUMP TO BEGGINING AFTER SEARCHING +++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(defun my-goto-match-beginning ()
      (when (and isearch-forward isearch-other-end (not isearch-mode-end-hook-quit))
        (goto-char isearch-other-end)))
(add-hook 'isearch-mode-end-hook 'my-goto-match-beginning)

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++ UNIQUIFY MODE +++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; display enough information to distinguish buffers with same names
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++ OTHER STUFF +++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(menu-bar-mode 1) ;; MENUBAR
(tool-bar-mode -1) ;; REMOVE TOOLBAR
(scroll-bar-mode -1) ;; REMOVE SCROLLBARS

;; AUTOMATICALLY RELOAD ALL TAGS WITHOUT ASKING IN A GUI
(setq tags-revert-without-query 1)

;; SHOW KEYSTROKES IN MINIBUFFER IMMEDIATEL
(setq echo-keystrokes 0.01)

;; END SENTENCES WITH ONE SPACE, NOT TWO (AFFECTS FILL COMMANDS)
(setq-default sentence-end-double-space nil)

;; LET WEEK START WITH MONDAY (NOT SUNDAY)
(setq calendar-week-start-day '1)

;; TREAT COMPRESSED FILES AS FOLDERS
(auto-compression-mode 1)

;; SET VARIABLE TO PREVENT WINDOW
(setq gnus-registry-install t)

;; SET VALUE
(setq mail-interactive nil)

;; ELECTRIC PARENTHESIS PAIRS
(electric-pair-mode 1)

;; HIGHLIGH CURRENT LINE
;; (highlight-current-line-minor-mode)

;; VISUAL LINE MODE - WRAP LONG LINES
(global-visual-line-mode)

;; ENABLE REGION SELECTING, USE C-ENTER
;; (cua-mode 1)

;; STACK TRACE IN CASE OF AN ERROR
(setq stack-trace-on-error t)

;; flush blank lines
(defun collapse-blank-lines ()
  "Delete blank lines."
  (interactive)
  (save-excursion
    (replace-regexp "^[ ]*\n\\{2,\\}" "\n\n" nil (point-min) (point-max)))
  )

(add-hook 'before-save-hook 'collapse-blank-lines)

;; SAVE WINDOWS OF THE FRAME
;; (defvar pre-ediff-window-configuration nil
;;   "window configuration to use")
;; (defvar new-ediff-frame-to-use nil
;;   "new frame for ediff to use")
;; (defun save-my-window-configuration ()
;;   (interactive)
;;   (setq pre-ediff-window-configuration (current-window-configuration))
;;   (select-frame-set-input-focus (setq new-ediff-frame-to-use (new-frame))))
;; (add-hook 'ediff-before-setup-hook 'save-my-window-configuration)
;; (defun restore-my-window-configuration ()
;;   (interactive)
;;   (when (framep new-ediff-frame-to-use)
;;      (delete-frame new-ediff-frame-to-use)
;;      (setq new-ediff-frame-to-use nil))
;;   (when (window-configuration-p pre-ediff-window-configuration
;;                                  (set-window-configuration pre-ediff-window-configuration)))
;;   (add-hook 'ediff-after-quit-hook-internal 'restore-my-window-configuration))

;; (restore-my-window-configuration)
;; (add-hook 'kill-emacs-hook 'save-my-window-configuration)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; basics.el ends here
