;;; jdee_config.el ---
;;
;; Filename: jdee_config.el
;; Description:
;; Author: Manuel Schneckenreither
;; Maintainer:
;; Created: So Okt 13 13:22:28 2013 (+0200)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Mi Okt 16 19:18:24 2013 (+0200)
;;           By: Manuel Schneckenreither
;;     Update #: 308
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
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++ JDEE CONFIG +++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(add-to-list 'load-path (concat package_folder "jdee-2.4.1/lisp"))
(autoload 'jde-mode "jde" "JDE mode" t)
(setq auto-mode-alist
      (append '(("\\.java\\'" . jde-mode)) auto-mode-alist))

;; (push 'jde-mode ac-modes)

(load "jde-autoload")
(setq jde-check-version-flag nil)
;; (setq jde-compile-option-directory
;;    (concat user-emacs-directory "/tmp"))

(defalias 'dired-rename-file 'rename-file)

(require 'gud)
(defun jde-my-minor ()
  (progn

    (add-to-list 'ac-sources 'ac-source-semantic)

    ;; (gtags-mode t)
    (glasses-mode t)
    ;; (auto-complete-mode t)
    ;; (add-to-list 'ac-sources ac-source-gtags)
    (local-set-key [f8] 'gud-next)
    (local-set-key [f9] 'gud-cont)
    ;; (local-set-key (kbd "M-/") 'hippie-expand)
    (local-set-key (kbd "M-n") 'jde-complete-minibuf)
    (add-hook 'before-save-hook
              (lambda ()
                (jde-import-all)
                (jde-import-organize)
                ;; (jde-import-kill-extra-imports)
                )
              nil t)
    ;; (add-hook 'after-save-hook 'jde-compile nil t)
    ))
(add-hook 'jde-mode-hook 'jde-my-minor)

(require 'jde-help)
;; w3 fail to load local file, so skip this feature
(defmethod jde-jdhelper-show-url ((this jde-jdhelper) url)
  (let ((doc-url (jde-url-name url)))
    (message "Displaying %s from %s"
             (oref url :class)
             (oref (oref url :docset) :description))
    (jde-jdhelper-show-document this doc-url)))


;; JUNIT
;; (setq jde-junit-testrunner-type "org.junit.runner.JUnitCore")
(setq jde-junit-testrunner-type "org.junit.runner.JUnitCore")

;; FIX PROJECT SETUP
(load-file (concat package_folder "jdee-2.4.1/lisp/jde-project-file.el"))

(setq jde-project-text
      "(jde-project-file-version \\\"1.0\\\")
(jde-set-variables
'(jde-compile-option-directory \\\"./classes\\\")
'(jde-sourcepath (quote (\\\"./src/main\\\" \\\"./src/test\\\")))
'(jde-global-classpath (quote (\\\"./classes\\\" \\\"./lib\\\"))))")


(defun jde-save-project ()
  "Saves source file buffer options in one or more project files.
This command provides an easy way to create and update a project file
for a Java project. Simply open a source file, set the desired
options, using the JDE Options menu, then save the settings in the
project file, using this command.  Now, whenever you open a source
file from the same directory tree, the saved settings will be restored
for that file."
  (interactive)
  (let* ((directory-sep-char ?/) ;; Override NT/XEmacs setting
	(project-file-paths (jde-find-project-files default-directory)))
    (if (not project-file-paths)
	(setq project-file-paths
	      (list (expand-file-name jde-project-file-name
				      (read-file-name "Save in directory: "
						      default-directory
						      default-directory)))))
    ;; (jde-save-project-internal project-file-paths)


    (shell-command
     (concat "echo \"" jde-project-text "\" > "
             (expand-file-name (nth 0 project-file-paths) jde-project-file-name)))
    ;; (message (expand-file-name (nth 0 project-file-paths) jde-project-file-name))
    ))


;; saving hooks
;; (add-hook 'before-save-hook
;;        (lambda ()
;;          (jde-import-kill-extra-imports)
;;          (jde-import-all)
;;          (jde-import-organize))
;;        nil t)
;; (add-hook 'after-save-hook 'jde-compile nil t)

;; (require 'auto-complete-config)
;; (ac-config-default)
;; (add-to-list 'ac-modes 'jde-mode)

;; (load (concat package_conf_folder "jdb-sourcepath.el"))
;; (require 'jdb-sourcepath)
;; (add-hook
;;  'jdb-mode-hook
;;  (lambda ()
;;    (set 'gud-jdb-sourcepath (jdb-sourcepath-from-rc))))
;; (run-at-time "1:00am" (* 60 60 24) 'jdb-setup)

;; ;; load source paths
;; (add-hook
;;  'jdb-mode-hook
;;  (lambda ()
;;    (load-file
;;  (concat
;;   user-emacs-directory
;;   (convert-standard-filename "var/jdb-directories.el")))))

;; ;; redefine class thru jdb
;; (gud-def
;;  gud-redefine
;;  (gud-call
;;   (format
;;    "redefine %%c %s/%s.class"
;;    (file-truename jde-compile-option-directory)
;;    (replace-regexp-in-string "\\." "/" (gud-format-command "%c" arg))))
;;  "\C-r" "Redefine class")

;; recognize output
;; (require 'compile)
;; (setq compilation-error-regexp-alist
;;    (list
;;     ;; works for maven 3.x
;;     '("^\\(\\[ERROR\\] \\)?\\(/[^:]+\\):\\[\\([0-9]+\\),\\([0-9]+\\)\\]" 2 3 4)
;;     ;; works for maven jde javac server
;;     '("^\\(/[^:]+\\):\\([0-9]+\\):" 1 2)
;;     ;; surefire
;;     '("^\\sw+(\\(\\sw+\\.\\)+\\(\\sw+\\)).+<<< \\(FAILURE\\|ERROR\\)!$"2)
;;     ))

;; append compilation snippets
;; (let ((snippets-buf
;;     (find-file-noselect
;;      (concat user-emacs-directory "/etc/java-compile.org")))
;;    (setq compile-history nil)
;;    (with-current-buffer
;;        snippets-buf
;;      (org-map-region
;;       '(lambda nil
;;          (add-to-list
;;           'compile-history
;;           (format
;;            "#%s\\\n%s"
;;            (nth 4 (org-heading-components))
;;            (mapconcat 'string (org-get-entry) ""))))
;;       1 (buffer-end 1))
;;      (kill-buffer snippets-buf)))

;; jdee maven plugin

;; (load-file (concat package_folder "jdee-2.4.1/jde-maven.el"))
;; (load-file (concat package_folder "jdee-2.4.1/lisp/jde-project.el"))

;; change create project stuff

;; (defgroup jde-project nil
;;   "JDE Project Options"
;;   :group 'jde
;;   :prefix "jde-project-")

;; (defclass jde-project-application (jde-project)
;;   ()
;;   "Class of JDE application projects")

;; (defmethod jde-project-create ((this jde-project-application))

;;   ;; little hack
;;   (setq package-name
;;         (read-string
;;          "Enter package (e.g. at.ac.uibk.csap3804.testproject): "
;;          "at.ac.uibk.csap3804"))

;;   (shell-command (concat "mvn archetype:create -DgroupId=" package-name
;;                            " -DartifactId=" (oref this name)   ;; project name
;;                            ))
;;   ;; end of hack one

;;   (if (not (file-exists-p (oref this dir)))
;;       (if (yes-or-no-p
;;            (format "%s does not exist. Should I create it?" (oref this dir)))
;;           (make-directory (oref this dir))
;;         (error "Cannot create project.")))

;;   ;; Make source directory
;;   (setq dir (expand-file-name "src" (oref this dir)))
;;   (if (not (file-exists-p dir)) (make-directory dir))

;;   ;; Make classes directory
;;   (setq dir (expand-file-name "classes" (oref this dir)))
;;   (if (not (file-exists-p dir)) (make-directory dir))

;; )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; jdee_config.el ends here
