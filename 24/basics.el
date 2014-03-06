;; basics.el ---
;;
;; Filename: basics.el
;; Status:
;; Author: Manuel Schneckenreither
;; Created: Mon Dec 10 22:51:09 2012 (+0100)
;; Version:
;; Last-Updated: Mi Mär  5 17:27:01 2014 (+0100)
;;           By: Manuel Schneckenreither
;;     Update #: 599
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

;; CLOSE/BURY THE COMPILATION WINDOW IF THERE WAS NO ERROR AT ALL.
(defun compilation-exit-autoclose (status code msg)
  ;; If M-x compile exists with a 0
  (when (and (eq status 'exit) (zerop code))
    ;; then bury the *compilation* buffer, so that C-x b doesn't go there
    (bury-buffer)
    ;; and delete/burry the *compilation* window
    (replace-buffer-in-windows "*compilation*")
    ;; (bury-buffer "*compilation*")
    (other-window 1)
    (shell)
    (return)) ;; open compilation window
  ;; Always return the anticipated result of compilation-exit-message-function
  (cons msg code))

;; SPECIFY FUNCTION
(setq compilation-exit-message-function 'compilation-exit-autoclose)


;; get the closest makefile
;; (defun get-above-makefile ()
;;   (loop as d = default-directory then (expand-file-name
;;                                        ".." d) if (file-exists-p (expand-file-name "Makefile" d)) return
;;                                        d))


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
(setq linum-format "%3d")

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

;; HIGHLIGH CURRENT LINE
;; (highlight-current-line-minor-mode)

;; Highlight keywords
(defun highlight-keywords ()
  "This function highlights keywords in files."

  (font-lock-add-keywords nil
                          '(("\\<\\(FIXME\\|TODO\\|BUG\\)" 1 font-lock-warning-face t))))


;; common c mode langauges like java, c, c++ are enabled with the
;; following line. All others are enabled in their specific language
;; configuration file, see the language_configs folder.
(add-hook 'c-mode-common-hook 'highlight-keywords)


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++ TAB SETTINGS ++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; TAB WIDTH
(setq-default tab-width 4)
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

;; format whole buffer - not bound to any key sequence
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


;; not bound to any key sequence
(defun insert-apostrophes (posBegin posEnd)
  "Insert apostrophes at beginning and end of region."
  (interactive "r")
  (region-insert-char posBegin posEnd "'" "'")
  )


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++ TAGS INFORMATION ++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; View tags other window - Bound to C-. in basic_keys.el
(defun view-tag-other-window (tagname &optional next-p regexp-p)
  "Same as `find-tag-other-window' but doesn't move the point"
  (interactive (find-tag-interactive "View tag other window: "))
  (let ((window (get-buffer-window)))
    (find-tag-other-window tagname next-p regexp-p)
    (recenter 10)
    (select-window window)))

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

;; create the autosave and backup dirs if necessary, since emacs won't.
(make-directory "~/.emacs.d/.tmp/autosaves/" t)
(make-directory "~/.emacs.d/.tmp/backups/" t)


;; Put autosave files (ie #foo#) and backup files (ie foo~) in ~/.emacs.d/.tmp/...
(setq auto-save-file-name-transforms (quote ((".*" "~/.emacs.d/.tmp/autosaves/\\1" t)))
      backup-directory-alist (quote ((".*" . "~/.emacs.d/.tmp/backups/")))
      )

(setq make-backup-files t               ; backup of a file the first time it is saved.
      backup-by-copying t               ; don't clobber symlinks
      version-control t                 ; version numbers for backup files
      delete-old-versions 0             ; delete excess backup files silently
      delete-by-moving-to-trash t
      kept-old-versions 32              ; oldest versions to keep when a new numbered backup is made (default: 2)
      kept-new-versions 4096            ; newest versions to keep when a new numbered backup is made (default: 2)
      vc-make-backup-files t            ; make backups even when file is in version control (e.g. git)


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
;; +++++++++++++++++++ SHOW KILL RING WHEN YANKING ++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

 (defun kill-ring-insert ()
   (interactive)
   (let (
        (to_insert (completing-read "Yank : "
                                    (delete-duplicates kill-ring :test #'equal)
                                    )))
     (when (and to_insert
               (region-active-p))
      ;; the currently highlighted section is to be replaced by the yank
      (delete-region (region-beginning) (region-end)))
     (insert to_insert))
   )

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++ AUTOMATICALLY WRAP LONG LINES +++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; set the wrapping length to column x
(setq fill-column 80)

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++ JUMP TO BEGINNING AFTER MATCH IN SEARCHING +++++++++++++++
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
;; +++++++++++++++++++++++++++++ BOOKMARKS ++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(setq
  bookmark-default-file (concat load-emacsd ".bookmarks") ;; keep my ~/ clean
  bookmark-save-flag 1)                        ;; autosave each change


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++ OTHER STUFF +++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(menu-bar-mode 1) ;; MENUBAR
(tool-bar-mode -1) ;; REMOVE TOOLBAR
(scroll-bar-mode -1) ;; REMOVE SCROLLBARS

;; DISABLE GUI DIALOG BOXES
(setq use-dialog-box nil)

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

;; OPEN MARKDOWN FILES WITH THE MARKDOWN MODE
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; basics.el ends here
