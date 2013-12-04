;;; java_config.el ---
;;
;; Filename: java_config.el
;; Description:
;; Author: Manuel Schneckenreither
;; Maintainer:
;; Created: Mo Okt 14 18:17:43 2013 (+0200)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Fr Nov 22 10:21:28 2013 (+0100)
;;           By: Manuel Schneckenreither
;;     Update #: 40
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

(require 'flymake)
(add-hook 'java-mode-hook 'flymake-mode-on)

(defun my-java-flymake-init ()
  (list "javac" (list (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-with-folder-structure))))

(add-to-list 'flymake-allowed-file-name-masks '("\\.java$" my-java-flymake-init flymake-simple-cleanup))

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
     (concat "cd " esdir " && find . -name \"*.java\" -print | etags - 1>/dev/null 2>/dev/null") t)
    (visit-tags-table (concat dir "TAGS"))
    )
  )

;; MINOR MODE HOOK
(defun my/java-minor-mode ()
  "Minor mode hook for Java."

  ;; auto complete mode
  (add-to-list 'ac-sources 'ac-source-etags)

  ;; glasses mode
  ;; (glasses-mode t)


  ;; CREATE AND SET TAGS FILE
  (add-hook 'after-save-hook 'make-java-tags nil t)
  )

(add-hook 'java-mode-hook 'my/java-minor-mode)
(add-hook 'jde-mode-hook 'my/java-minor-mode)

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; Java flymake
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; FLYMAKE CONFIG -- FLYCHECK DOES NOT SUPPORT JAVA YET!

;; (require 'flymake)
;; (add-hook 'java-mode-hook 'flymake-mode-on)

;; (require 'jde)
;; (require 'flymake)

;; (defgroup jde-flymake nil
;;   "JDE Jalopy Options"
;;   :group 'jde
;;   :group 'flymake
;;   :prefix "jde-"
;;   )

;; ;; (makunbound 'jde-sourcepath)
;; (defcustom jde-flymake-sourcepath nil
;;   "*List of source directory paths.  it should be a subset of jde-sourcepath.
;;   if nul try to get `jde-sourcepath'."
;;   :group 'jde-flymake
;;   :type '(repeat (file :tag "Path")))

;; (defcustom jde-flymake-option-jikes-source "1.4"
;;   "*Specify which Java SDK release the source syntax obeys. For example,
;;   to compile code with the assert keyword, you would specify -source 1.4.
;;   Recognized releases are 1.1 through 1.4. If unspecified, this defaults to 1.3."
;;   :group 'jde-flymake
;;   :type 'string)

;; (defcustom jde-flymake-jikes-app-name "jikes"
;;   "*Allows an absolute path to be set for the jikes compiler.
;;   The default is to attempt to load it from the path."
;;   :group 'jde-flymake
;;   :type 'string)

;; ;; since this
;; (defun flymake-jde-jikes-java-init(buffer)
;;   "Returns the jikes command line for a directly checked source file, use create-temp-f for creating temp copy"
;;   "Currently uses the directory of the prj.el file as the execution directory for"
;;   "jikes (root of the source tree). Another option would be to use the package as determined by"
;;   "jde-package and go up the directory tree the appropriate number of levels (segments in the package name"
;;   (let* ((jikes-args          nil)
;;    (source-file-name   (buffer-file-name buffer))
;;    (prjfile-name        (jde-find-project-file (file-name-directory source-file-name))))
;;     (if prjfile-name
;;   (let* ((temp-source-file-name
;;                 (flymake-init-create-temp-buffer-copy
;;                  buffer
;;                  'flymake-create-temp-with-folder-structure)))
;;           (setq jikes-args (flymake-get-jikes-args temp-source-file-name (file-name-directory prjfile-name))))
;;       (error "JDE project file not found")
;;       )

;;     (if jikes-args
;;   ;; assumes jikes is on the path
;;   (list jde-flymake-jikes-app-name jikes-args)
;;                                         ;else
;;       nil)))

;; (defun jde-flymake-customize ()
;;   "Show the jde-javadoc options panel."
;;   (interactive)
;;   (customize-group "jde-flymake"))

;; (defun flymake-get-jikes-args(source-file-name base-dir)
;;   "create a command line for the jikes syntax check command"
;;   (progn
;;     ;; check dependencies
;;     (if (not jde-sourcepath)
;;         (error "The variable jde-sourcepath is not configured"))
;;     (if (not jde-global-classpath)
;;         (error "The variable jde-global-classpath is not configured"))
;;     (let* (
;;      (rt-jar (expand-file-name "jre/lib/rt.jar" (jde-normalize-path (jde-get-jdk-dir))))
;;      (proj-classpath (jde-build-classpath jde-global-classpath))
;;      (proj-sourcepath (jde-build-classpath
;;            (if (not jde-flymake-sourcepath)
;;                jde-sourcepath
;;              jde-flymake-sourcepath))))

;;       ;;TODO: make jikes flags configurable
;;       ;;  (list jde-flymake-option-jikes
;;       (list "-nowrite" "+E" "+D" "+P" "+Pno-naming-convention" "-deprecation"
;;       "-source" jde-flymake-option-jikes-source
;;       "-bootclasspath" rt-jar
;;       "-classpath" proj-classpath
;;       "-sourcepath" proj-sourcepath
;;       source-file-name))))


(require 'cl)

(defvar flyc--e-at-point nil
  "Error at point, after last command")

(defvar flyc--e-display-timer nil
  "A timer; when it fires, it displays the stored error message.")

(defun flyc/maybe-fixup-message (errore)
  "pyflake is flakey if it has compile problems, this adjusts the
message to display, so there is one ;)"
  (cond ((not (or (eq major-mode 'Python) (eq major-mode 'python-mode) t)))
        ((null (flymake-ler-file errore))
         ;; normal message do your thing
         (flymake-ler-text errore))
        (t ;; could not compile error
         (format "compile error, problem on line %s" (flymake-ler-line errore)))))

(defun flyc/show-stored-error-now ()
  "Displays the stored error in the minibuffer."
  (interactive)
  (let ((editing-p (= (minibuffer-depth) 0)))
   (if (and flyc--e-at-point editing-p)
       (progn
         (message "%s" (flyc/maybe-fixup-message flyc--e-at-point))
         (setq flyc--e-display-timer nil)))))

(defun flyc/-get-error-at-point ()
  "Gets the first flymake error on the line at point."
  (let ((line-no (line-number-at-pos))
        flyc-e)
    (dolist (elem flymake-err-info)
      (if (eq (car elem) line-no)
          (setq flyc-e (car (second elem)))))
    flyc-e))

;;;###autoload
(defun flyc/show-fly-error-at-point-now ()
  "If the cursor is sitting on a flymake error, display
the error message in the  minibuffer."
  (interactive)
  (if flyc--e-display-timer
      (progn
        (cancel-timer flyc--e-display-timer)
        (setq flyc--e-display-timer nil)))
  (let ((error-at-point (flyc/-get-error-at-point)))
    (if error-at-point
        (progn
          (setq flyc--e-at-point error-at-point)
          (flyc/show-stored-error-now)))))

;;;###autoload
(defun flyc/show-fly-error-at-point-pretty-soon ()
  "If the cursor is sitting on a flymake error, grab the error,
and set a timer for \"pretty soon\". When the timer fires, the error
message will be displayed in the minibuffer.

This allows a post-command-hook to NOT cause the minibuffer to be
updated 10,000 times as a user scrolls through a buffer
quickly. Only when the user pauses on a line for more than a
second, does the flymake error message (if any) get displayed.

"
  (if flyc--e-display-timer
      (cancel-timer flyc--e-display-timer))

  (let ((error-at-point (flyc/-get-error-at-point)))
    (if error-at-point
        (setq flyc--e-at-point error-at-point
              flyc--e-display-timer
              (run-at-time "0.9 sec" nil 'flyc/show-stored-error-now))
      (setq flyc--e-at-point nil
            flyc--e-display-timer nil))))

;;;###autoload
(eval-after-load "flymake"
  '(progn

     (defadvice flymake-goto-next-error (after flyc/display-message-1 activate compile)
       "Display the error in the mini-buffer rather than having to mouse over it"
       (flyc/show-fly-error-at-point-now))

     (defadvice flymake-goto-prev-error (after flyc/display-message-2 activate compile)
       "Display the error in the mini-buffer rather than having to mouse over it"
       (flyc/show-fly-error-at-point-now))

     (defadvice flymake-mode (before flyc/post-command-fn activate compile)
       "Add functionality to the post command hook so that if the
cursor is sitting on a flymake error the error information is
displayed in the minibuffer (rather than having to mouse over
it)"
       (add-hook 'post-command-hook 'flyc/show-fly-error-at-point-pretty-soon t t))))

(defun credmp/flymake-display-err-minibuf ()
  "Displays the error/warning for the current line in the minibuffer"
  (interactive)
  (let* ((line-no             (flymake-current-line-no))
         (line-err-info-list  (nth 0 (flymake-find-err-info
                                      flymake-err-info line-no)))
         (count               (length line-err-info-list))
         )
    (while (> count 0)
      (when line-err-info-list
        (let* ((file       (flymake-ler-file (nth (1- count)
                                                  line-err-info-list)))
               (full-file  (flymake-ler-full-file (nth (1- count)
                                                       line-err-info-list)))
               (text (flymake-ler-text (nth (1- count) line-err-info-list)))
               (line       (flymake-ler-line (nth (1- count)
                                                  line-err-info-list))))
          (message "[%s] %s" line text)
          )
        )
      (setq count (1- count)))))

(setq help-at-pt-timer-delay 0.2)
;; (setq help-at-pt-display-when-idle '(flymake-overlay))
(setq help-at-pt-display-when-idle '(credmp/flymake-display-err-minibuf))

(custom-set-faces
 '(flymake-errline ((((class color)) (:underline "red"))))
 '(flymake-warnline ((((class color)) (:underline "yellow")))))


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++ ENHANCEMENTS FOR DISPLAYING FLYMAKE ERRORS ++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; (defun flymake:display-err-minibuf-for-current-line ()
;;   "Displays the error/warning for the current line in the minibuffer"
;;   (interactive)
;;   (let* ((line-no            (flymake-current-line-no))
;;          (line-err-info-list (nth 0 (flymake-find-err-info flymake-err-info line-no)))
;;          (count              (length line-err-info-list)))
;;     (while (> count 0)
;;       (when line-err-info-list
;;         (let* ((text       (flymake-ler-text (nth (1- count) line-err-info-list)))
;;                (line       (flymake-ler-line (nth (1- count) line-err-info-list))))
;;           (message "[%s] %s" line text)))
;;       (setq count (1- count))))
;;   )

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

;; ;; SHOW NEXT ERROR FUNCTION
;; (defun my-flymake-show-next-error()
;;   (interactive)
;;   (flymake-goto-next-error)
;;   ;; (flymake:display-err-popup-for-current-line)
;;   (flymake-display-err-menu-for-current-line)
;;   )

;; ;; SHOW PREV ERROR FUNCTION
;; (defun my-flymake-show-prev-error()
;;   (interactive)
;;   (flymake-goto-prev-error)
;;   (flymake:display-err-popup-for-current-line)
;;   ;;(flymake-display-err-menu-for-current-line)
;;   )

;; Overwrite flymake-display-warning so that no annoying dialog box is
;; used.

;; This version uses lwarn instead of message-box in the original version.
;; lwarn will open another window, and display the warning in there.
;; (defun flymake-display-warning (warning)
;;   "Display a warning to the user, using lwarn"
;;   (lwarn 'flymake :warning warning))

;; Using lwarn might be kind of annoying on its own, popping up windows and
;; what not. If you prefer to recieve the warnings in the mini-buffer, use:
;; (defun flymake-display-warning (warning)
;;   "Display a warning to the user, using lwarn"
;;   (message warning))

;; ;; FLYMAKE TEMP FOLDER
;; (make-directory "~/.emacs.d/.tmp/flymake/" t)
;; (setq temporary-file-directory "~/.emacs.d/.tmp/flymake/")


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++ FLYMAKE CONFIGURATION ++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


;;FLYMAKE (ENHANCEMENTS)
;; (global-set-key (kbd (concat prefix-command-key " n")) 'my-flymake-show-next-error)
;; (global-set-key (kbd (concat prefix-command-key " p")) 'my-flymake-show-prev-error)

;;ASOCIATE KEY FOR CURRENT ERROR POPUP/MINIBUFFER
(global-set-key (kbd (concat prefix-command-key " e")) 'flymake:display-err-popup-for-current-line)
;; (global-set-key (kbd (concat prefix-command-key " e")) 'flymake:display-err-minibuf-for-current-line)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; java_config.el ends here
