;;; cedet_config.el --- 
;; 
;; Filename: cedet_config.el
;; Description: 
;; Author: Manuel Schneckenreither
;; Maintainer: 
;; Created: So Okt 13 11:05:43 2013 (+0200)
;; Version: 
;; Package-Requires: ()
;; Last-Updated: So Okt 13 12:43:32 2013 (+0200)
;;           By: Manuel Schneckenreither
;;     Update #: 17
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;; Code:


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++ BUILD CEDET  ++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; (defun byte-compile-cedet ()
;;   (load (concat package_folder "cedet-1.1/cedet-build.el"))
;;   (cedet-build-in-default-emacs)
;;   (message "CEDET BUILT"))


;; ;; DO ONLY IF NOT BUILT YET
;; (if (not (file-exists-p (concat package_folder
;;                                 "cedet-1.1/common/cedet.elc")))
;;     (byte-compile-cedet))



;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++ CEDET CONFIG ++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



;; Load CEDET.
;; IMPORTANT: Tou must place this *before* any CEDET component (including
;; EIEIO) gets activated by another package (Gnus, auth-source, ...).
(setq cedet-root-path (file-name-as-directory (concat package_folder "cedet/")))
 
(load-file (concat cedet-root-path "cedet-devel-load.el"))
(add-to-list 'load-path (concat cedet-root-path "contrib"))
 
;; select which submodes we want to activate
(add-to-list 'semantic-default-submodes 'global-semantic-mru-bookmark-mode)
(add-to-list 'semantic-default-submodes 'global-semanticdb-minor-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-scheduler-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-stickyfunc-mode)
(add-to-list 'semantic-default-submodes 'global-cedet-m3-minor-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-highlight-func-mode)
(add-to-list 'semantic-default-submodes 'global-semanticdb-minor-mode)
 
;; Activate semantic
(semantic-mode 1)
 
;; load contrib library
(require 'eassist)
 
;; customisation of modes
(defun alexott/cedet-hook ()
(local-set-key [(control return)] 'semantic-ia-complete-symbol-menu)
(local-set-key "\C-c?" 'semantic-ia-complete-symbol)
;;
(local-set-key "\C-c>" 'semantic-complete-analyze-inline)
(local-set-key "\C-c=" 'semantic-decoration-include-visit)
 
(local-set-key "\C-cj" 'semantic-ia-fast-jump)
(local-set-key "\C-cq" 'semantic-ia-show-doc)
(local-set-key "\C-cs" 'semantic-ia-show-summary)
(local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)
)
(add-hook 'c-mode-common-hook 'alexott/cedet-hook)
(add-hook 'lisp-mode-hook 'alexott/cedet-hook)
(add-hook 'scheme-mode-hook 'alexott/cedet-hook)
(add-hook 'emacs-lisp-mode-hook 'alexott/cedet-hook)
(add-hook 'erlang-mode-hook 'alexott/cedet-hook)
 
(defun alexott/c-mode-cedet-hook ()
(local-set-key "\C-ct" 'eassist-switch-h-cpp)
(local-set-key "\C-xt" 'eassist-switch-h-cpp)
(local-set-key "\C-ce" 'eassist-list-methods)
(local-set-key "\C-c\C-r" 'semantic-symref)
)
(add-hook 'c-mode-common-hook 'alexott/c-mode-cedet-hook)
 
(semanticdb-enable-gnu-global-databases 'c-mode t)
(semanticdb-enable-gnu-global-databases 'c++-mode t)
 
(when (cedet-ectag-version-check t)
(semantic-load-enable-primary-ectags-support))
 
;; SRecode
(global-srecode-minor-mode 1)
 
;; EDE
(global-ede-mode 1)
(ede-enable-generic-projects)
 
 
;; Setup JAVA....
(require 'cedet-java)

















;; ;; Load CEDET.
;; ;; IMPORTANT: Tou must place this *before* any CEDET component (including
;; ;; EIEIO) gets activated by another package (Gnus, auth-source, ...).
;; (load-file (concat package_folder "cedet/cedet-devel-load.el"))

;; ;; loading contrib...
;; ;; (load-file (concat package_folder "cedet/contrib/cedet-contrib-load.el"))

;; ;; (add-to-list 'Info-directory-list (concat package_folder "~/projects/cedet-bzr/doc/info")"cedet/contrib/cedet-contrib-load.el"))


;; ;; (require 'semantic/bovine/c)
;; ;; (require 'semantic/bovine/clang)
;; ;; (require 'cedet-files)
;; ;; (require 'eassist)
;; ;; (require 'semantic/ia)

;; ;; Add further minor-modes to be enabled by semantic-mode.
;; ;; See doc-string of `semantic-default-submodes' for other things
;; ;; you can use here.
;; (add-to-list 'semantic-default-submodes 'global-semanticdb-minor-mode t)
;; ;; enables global support for Semanticdb;
;; (add-to-list 'semantic-default-submodes 'global-semantic-mru-bookmark-mode t)
;; ;; enables automatic bookmarking of tags that you edited,
;; ;; so you can return to them later with the semantic-mrub-switch-tags command;
;; (add-to-list 'semantic-default-submodes 'global-semantic-mru-bookmark-mode t)
;; ;; activates CEDET's context menu that is bound to right mouse button;
;; (add-to-list 'semantic-default-submodes 'global-semantic-highlight-func-mode t)
;; ;; activates highlighting of first line for current tag (function, class, etc.);
;; (add-to-list 'semantic-default-submodes 'global-semantic-stickyfunc-mode t)
;; ;; activates mode when name of current tag will be shown in top line of buffer;
;; (add-to-list 'semantic-default-submodes 'global-semantic-decoration-mode t)
;; ;; activates use of separate styles for tags decoration (depending on tag's class).
;; ;; These styles are defined in the semantic-decoration-styles list;
;; (add-to-list 'semantic-default-submodes 'global-semantic-idle-local-symbol-highlight-mode t)
;; ;; activates highlighting of local names that are the same as name of tag under cursor;
;; (add-to-list 'semantic-default-submodes 'global-semantic-idle-scheduler-mod t)
;; ;; activates automatic parsing of source code in the idle time;
;; (add-to-list 'semantic-default-submodes 'global-semantic-idle-completions-mode t)
;; ;; activates displaying of possible name completions in the idle time.
;; ;; Requires that global-semantic-idle-scheduler-mode was enabled
;; (add-to-list 'semantic-default-submodes 'global-semantic-idle-summary-mode t)
;; ;; activates displaying of information about current tag in the idle time.
;; ;; Requires that global-semantic-idle-scheduler-mode was enabled.


;; ;; Enable Semantic
;; (semantic-mode 1)

;; ;; To enable more advanced functionality for name completion, etc., you
;; ;; can load the semantic/ia with following command:
;; (require 'semantic/ia)



;; ;; AFTER LOADING OF THIS PACKAGE, YOU'LL GET ACCESS TO COMMANDS, DESCRIBED BELOW.
;; ;; -------------------------------------------------------------------------------


;; ;; ;; Enable EDE (Project Management) features
;; ;; (global-ede-mode 1)
;; ;; (ede-enable-generic-projects)

;; ;; ;; SRecode
;; ;; (global-srecode-minor-mode 1)



;; ;; SYSTEM HEADER FILES
;; ;; To normal work with system-wide libraries, Semantic should has access to system include files,
;; ;; that contain information about functions & data types, implemented by these libraries.

;; ;; If you're using GCC for programming in C & C++, then Semantic can automatically find directory,
;; ;; where system include files are stored. Just load semantic/bovine/gcc package with following
;; ;; command:

;; (require 'semantic/bovine/gcc)

;; ;; You can also explicitly specify additional directories for searching of include files (and these
;; ;; directories also could be different for specific modes). To add some directory to list of system
;; ;; include paths, you can use the semantic-add-system-include command — it accepts two parameters:
;; ;; string with path to include files, and symbol, representing name of major mode, for which this
;; ;; path will be used. For example, to add Boost header files for C++ mode, you need to add following
;; ;; code:

;; ;; (semantic-add-system-include "~/exp/include/boost_1_37" 'c++-mode)


;; ;; To optimize work with tags, you can use several techniques:

;; ;;  - limit search by using an EDE project, as described below;
;; ;;  - explicitly specify a list of root directories for your projects, so Semantic will use limited
;; ;;    number of databases with syntactic information;
;; ;;  - explicitly generate tags databases for often used directories (/usr/include, /usr/local/include, etc.).
;; ;;    You can use commands semanticdb-create-ebrowse-database or semanticdb-create-cscope-database;
;; ;;  - limit search by customization of the semanticdb-find-default-throttle variable for concrete modes —
;; ;;    for example, don't use information from system include files, by removing system symbol from list
;; ;;    of objects to search for c-mode:

;; ;; (setq-mode-local c-mode semanticdb-find-default-throttle
;; ;;                  '(project unloaded system recursive))

;; ;; INTEGRATION WITH IMENU

;; (defun my-semantic-hook ()
;;   (imenu-add-to-menubar "TAGS"))
;; (add-hook 'semantic-init-hooks 'my-semantic-hook)


;; ;; SEMANTICDB
;; ;; if you want to enable support for gnu global
;; (when (cedet-gnu-global-version-check t)
;;   (semanticdb-enable-gnu-global-databases 'c-mode)
;;   (semanticdb-enable-gnu-global-databases 'c++-mode))

;; ;; enable ctags for some languages:
;; ;;  Unix Shell, Perl, Pascal, Tcl, Fortran, Asm
;; (when (cedet-ectag-version-check)
;;   (semantic-load-enable-primary-exuberent-ctags-support))


;; ;; PROJECTS
;; (global-ede-mode t)



;; ;; C PROJECTS
;; ;; ------------


;; (defun my-c-mode-cedet-hook ()
;;   (add-to-list 'ac-sources 'ac-source-gtags)
;;   (add-to-list 'ac-sources 'ac-source-semantic))
;; (add-hook 'global-mode-hook 'my-c-mode-cedet-hook)


;; ;; TODO



;; ;; JAVA PROJECTS
;; ;; --------------

;; (require 'semantic/db-javap)

;; ;; todo add maven





;; ;; SOURCE CODE FOLDING

;; (setq global-semantic-tag-folding-mode 1)


;; ;; ;; CUSTOMIZATION OF SEMANTIC DB




;; ;; ;; if you want to enable support for gnu global
;; ;; (when (cedet-gnu-global-version-check t)
;; ;;   (semanticdb-enable-gnu-global-databases 'c-mode)
;; ;;   (semanticdb-enable-gnu-global-databases 'c++-mode))

;; ;; ;; enable ctags for some languages:










;; ;; ;;  Unix Shell, Perl, Pascal, Tcl, Fortran, Asm
;; ;; (when (cedet-ectag-version-check)
;; ;;   (semantic-load-enable-primary-exuberent-ctags-support))


;; ;; ;; setup compile package
;; ;; (require 'compile)
;; ;; (setq compilation-disable-input nil)
;; ;; (setq compilation-scroll-output t)
;; ;; (setq mode-compile-always-save-buffer-p t)

;; ;; (defun alexott/compile ()
;; ;;   "Saves all unsaved buffers, and runs 'compile'."
;; ;;   (interactive)
;; ;;   (save-some-buffers t)
;; ;;   (let* ((fname (or (buffer-file-name (current-buffer)) default-directory))
;; ;;          (current-dir (file-name-directory fname))
;; ;;          (prj (ede-current-project current-dir)))
;; ;;     (if prj
;; ;;         (project-compile-project prj)
;; ;;       (compile compile-command))))
;; ;; (global-set-key [f9] 'alexott/compile)


;; ;; (defun alexott/gen-std-compile-string ()
;; ;;   "Generates compile string for compiling CMake project in debug mode"
;; ;;   (let* ((current-dir (file-name-directory
;; ;;                        (or (buffer-file-name (current-buffer)) default-directory)))
;; ;;          (prj (ede-current-project current-dir))
;; ;;          (root-dir (ede-project-root-directory prj)))
;; ;;     (concat "cd " root-dir "; make -j2")))


;; ;; (defun alexott/gen-cmake-debug-compile-string ()
;; ;;   "Generates compile string for compiling CMake project in debug mode"
;; ;;   (let* ((current-dir (file-name-directory
;; ;;                        (or (buffer-file-name (current-buffer)) default-directory)))
;; ;;          (prj (ede-current-project current-dir))
;; ;;          (root-dir (ede-project-root-directory prj))
;; ;;          (subdir "")
;; ;;          )
;; ;;     (when (string-match root-dir current-dir)
;; ;;       (setf subdir (substring current-dir (match-end 0))))
;; ;;     (concat "cd " root-dir "Debug/" "; make -j3")))


;; ;; ;; JAVA SUPPORT

;; ;; (require 'semantic/db-javap)




;; ;; ;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ;; ;; +++++++++++++++++++++++++++ GLOBAL KEYS ++++++++++++++++++++++++++++++
;; ;; ;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; ;; (global-set-key [(control return)] 'semantic-ia-complete-symbol)
;; ;; ;; (global-set-key "\C-c?" 'semantic-ia-complete-symbol-menu)
;; ;; ;; (global-set-key "\C-c>" 'semantic-complete-analyze-inline)
;; ;; ;; (global-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)



;; ;; ;; bind eassist-list-message
;; ;; (global-set-key (kbd "C-x x h") 'semantic-analyze-proto-impl-toggle)
;; ;; (global-set-key (kbd "C-x x i") 'semantic-ia-fast-jump)
;; ;; (global-set-key (kbd "C-x x o") 'semantic-mrub-switch-tags)
;; ;; (global-set-key (kbd "C-x x l") 'semantic-decoration-include-visit)

;; ;; (global-set-key (kbd "C-x x f") 'eassist-list-methods)
;; ;; ;; (global-set-key (kbd "C-c s") 'eassist-switch-h-cpp )
;; ;; ;; (global-set-key (kbd "C-c u") 'speedbar-update-contents)
;; ;; ;; (global-set-key (kbd "C-c f") 'speedbar-get-focus)

;; ;; (global-set-key (kbd "C-x x d") 'semantic-ia-show-doc)
;; ;; (global-set-key (kbd "C-x x s") 'semantic-ia-show-summary)
;; ;; (global-set-key (kbd "C-x x <left>") 'semantic-tag-folding-fold-block)
;; ;; (global-set-key (kbd "C-x x <right>") 'semantic-tag-folding-show-block)


;; ;; ;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ;; ;; +++++++++++++++++++++++++ LOCAL HOOKS/KEYS +++++++++++++++++++++++++++
;; ;; ;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


;; ;; ;; GETTING INFORMATION ABOUT TAGS

;; ;; ;; The semantic/ia package provides several commands, that allow to get
;; ;; ;; information about classes, functions & variables (including documentation
;; ;; ;; from Doxygen-style comments). Currently following commands are implemented:

;; ;; ;; semantic-ia-show-doc
;; ;; ;;     shows documentation for function or variable, whose names is under point.
;; ;; ;;     Documentation is shown in separate buffer. For variables this command
;; ;; ;;     shows their declaration, including type of variable, and documentation
;; ;; ;;     string (if it's available). For functions, prototype of the function is
;; ;; ;;     shown, including documentation for arguments and returning value(if
;; ;; ;;     comments are available);

;; ;; ;; semantic-ia-show-summary
;; ;; ;;     shows documentation for name under point, but information is shown in the
;; ;; ;;     mini-buffer, so user will see only variable's declaration or function's
;; ;; ;;    prototype;

;; ;; ;; semantic-ia-describe-class
;; ;; ;;     asks user for a name of the class, and return list of functions &
;; ;; ;;     variables, defined in given class, plus all its parent classes.




;; ;; ;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ;; ;; ++++++++++++++++++++++ LOAD PROJECT FILES ++++++++++++++++++++++++++++
;; ;; ;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; ;; ;; Project files
;; ;; (defun load-project-files (file-list)
;; ;;   (dolist (file file-list)
;; ;;     (load-file (concat project_folder file))))


;; ;; (load-project-files
;; ;;  (directory-files project_folder nil "^\\([^.]\\|\\.[^.]\\|\\.\\..\\)"))

;; ;; ;; CEDET END
























;; ;; Load CEDET.
;; ;; IMPORTANT: Tou must place this *before* any CEDET component (including
;; ;; EIEIO) gets activated by another package (Gnus, auth-source, ...).
;; (load-file (concat package_folder "cedet/cedet-devel-load.el"))

;; ;; loading contrib...
;; ;; (load-file (concat package_folder "cedet/contrib/cedet-contrib-load.el"))

;; ;; (add-to-list 'Info-directory-list (concat package_folder "~/projects/cedet-bzr/doc/info")"cedet/contrib/cedet-contrib-load.el"))


;; ;; (require 'semantic/bovine/c)
;; ;; (require 'semantic/bovine/clang)
;; ;; (require 'cedet-files)
;; ;; (require 'eassist)
;; ;; (require 'semantic/ia)

;; ;; Add further minor-modes to be enabled by semantic-mode.
;; ;; See doc-string of `semantic-default-submodes' for other things
;; ;; you can use here.
;; (add-to-list 'semantic-default-submodes 'global-semanticdb-minor-mode t)
;; ;; enables global support for Semanticdb;
;; (add-to-list 'semantic-default-submodes 'global-semantic-mru-bookmark-mode t)
;; ;; enables automatic bookmarking of tags that you edited,
;; ;; so you can return to them later with the semantic-mrub-switch-tags command;
;; (add-to-list 'semantic-default-submodes 'global-semantic-mru-bookmark-mode t)
;; ;; activates CEDET's context menu that is bound to right mouse button;
;; (add-to-list 'semantic-default-submodes 'global-semantic-highlight-func-mode t)
;; ;; activates highlighting of first line for current tag (function, class, etc.);
;; (add-to-list 'semantic-default-submodes 'global-semantic-stickyfunc-mode t)
;; ;; activates mode when name of current tag will be shown in top line of buffer;
;; (add-to-list 'semantic-default-submodes 'global-semantic-decoration-mode t)
;; ;; activates use of separate styles for tags decoration (depending on tag's class).
;; ;; These styles are defined in the semantic-decoration-styles list;
;; (add-to-list 'semantic-default-submodes 'global-semantic-idle-local-symbol-highlight-mode t)
;; ;; activates highlighting of local names that are the same as name of tag under cursor;
;; (add-to-list 'semantic-default-submodes 'global-semantic-idle-scheduler-mod t)
;; ;; activates automatic parsing of source code in the idle time;
;; (add-to-list 'semantic-default-submodes 'global-semantic-idle-completions-mode t)
;; ;; activates displaying of possible name completions in the idle time.
;; ;; Requires that global-semantic-idle-scheduler-mode was enabled
;; (add-to-list 'semantic-default-submodes 'global-semantic-idle-summary-mode t)
;; ;; activates displaying of information about current tag in the idle time.
;; ;; Requires that global-semantic-idle-scheduler-mode was enabled.


;; ;; Enable Semantic
;; (semantic-mode 1)

;; ;; To enable more advanced functionality for name completion, etc., you
;; ;; can load the semantic/ia with following command:
;; (require 'semantic/ia)



;; ;; AFTER LOADING OF THIS PACKAGE, YOU'LL GET ACCESS TO COMMANDS, DESCRIBED BELOW.
;; ;; -------------------------------------------------------------------------------


;; ;; ;; Enable EDE (Project Management) features
;; ;; (global-ede-mode 1)
;; ;; (ede-enable-generic-projects)

;; ;; ;; SRecode
;; ;; (global-srecode-minor-mode 1)



;; ;; SYSTEM HEADER FILES
;; ;; To normal work with system-wide libraries, Semantic should has access to system include files,
;; ;; that contain information about functions & data types, implemented by these libraries.

;; ;; If you're using GCC for programming in C & C++, then Semantic can automatically find directory,
;; ;; where system include files are stored. Just load semantic/bovine/gcc package with following
;; ;; command:

;; (require 'semantic/bovine/gcc)

;; ;; You can also explicitly specify additional directories for searching of include files (and these
;; ;; directories also could be different for specific modes). To add some directory to list of system
;; ;; include paths, you can use the semantic-add-system-include command — it accepts two parameters:
;; ;; string with path to include files, and symbol, representing name of major mode, for which this
;; ;; path will be used. For example, to add Boost header files for C++ mode, you need to add following
;; ;; code:

;; ;; (semantic-add-system-include "~/exp/include/boost_1_37" 'c++-mode)


;; ;; To optimize work with tags, you can use several techniques:

;; ;;  - limit search by using an EDE project, as described below;
;; ;;  - explicitly specify a list of root directories for your projects, so Semantic will use limited
;; ;;    number of databases with syntactic information;
;; ;;  - explicitly generate tags databases for often used directories (/usr/include, /usr/local/include, etc.).
;; ;;    You can use commands semanticdb-create-ebrowse-database or semanticdb-create-cscope-database;
;; ;;  - limit search by customization of the semanticdb-find-default-throttle variable for concrete modes —
;; ;;    for example, don't use information from system include files, by removing system symbol from list
;; ;;    of objects to search for c-mode:

;; ;; (setq-mode-local c-mode semanticdb-find-default-throttle
;; ;;                  '(project unloaded system recursive))

;; ;; INTEGRATION WITH IMENU

;; (defun my-semantic-hook ()
;;   (imenu-add-to-menubar "TAGS"))
;; (add-hook 'semantic-init-hooks 'my-semantic-hook)


;; ;; SEMANTICDB
;; ;; if you want to enable support for gnu global
;; (when (cedet-gnu-global-version-check t)
;;   (semanticdb-enable-gnu-global-databases 'c-mode)
;;   (semanticdb-enable-gnu-global-databases 'c++-mode))

;; ;; enable ctags for some languages:
;; ;;  Unix Shell, Perl, Pascal, Tcl, Fortran, Asm
;; (when (cedet-ectag-version-check)
;;   (semantic-load-enable-primary-exuberent-ctags-support))


;; ;; PROJECTS
;; (global-ede-mode t)



;; ;; C PROJECTS
;; ;; ------------


;; (defun my-c-mode-cedet-hook ()
;;   (add-to-list 'ac-sources 'ac-source-gtags)
;;   (add-to-list 'ac-sources 'ac-source-semantic))
;; (add-hook 'global-mode-hook 'my-c-mode-cedet-hook)


;; ;; TODO



;; ;; JAVA PROJECTS
;; ;; --------------

;; (require 'semantic/db-javap)

;; ;; todo add maven





;; ;; SOURCE CODE FOLDING

;; (setq global-semantic-tag-folding-mode 1)


;; ;; ;; CUSTOMIZATION OF SEMANTIC DB




;; ;; ;; if you want to enable support for gnu global
;; ;; (when (cedet-gnu-global-version-check t)
;; ;;   (semanticdb-enable-gnu-global-databases 'c-mode)
;; ;;   (semanticdb-enable-gnu-global-databases 'c++-mode))

;; ;; ;; enable ctags for some languages:










;; ;; ;;  Unix Shell, Perl, Pascal, Tcl, Fortran, Asm
;; ;; (when (cedet-ectag-version-check)
;; ;;   (semantic-load-enable-primary-exuberent-ctags-support))


;; ;; ;; setup compile package
;; ;; (require 'compile)
;; ;; (setq compilation-disable-input nil)
;; ;; (setq compilation-scroll-output t)
;; ;; (setq mode-compile-always-save-buffer-p t)

;; ;; (defun alexott/compile ()
;; ;;   "Saves all unsaved buffers, and runs 'compile'."
;; ;;   (interactive)
;; ;;   (save-some-buffers t)
;; ;;   (let* ((fname (or (buffer-file-name (current-buffer)) default-directory))
;; ;;          (current-dir (file-name-directory fname))
;; ;;          (prj (ede-current-project current-dir)))
;; ;;     (if prj
;; ;;         (project-compile-project prj)
;; ;;       (compile compile-command))))
;; ;; (global-set-key [f9] 'alexott/compile)


;; ;; (defun alexott/gen-std-compile-string ()
;; ;;   "Generates compile string for compiling CMake project in debug mode"
;; ;;   (let* ((current-dir (file-name-directory
;; ;;                        (or (buffer-file-name (current-buffer)) default-directory)))
;; ;;          (prj (ede-current-project current-dir))
;; ;;          (root-dir (ede-project-root-directory prj)))
;; ;;     (concat "cd " root-dir "; make -j2")))


;; ;; (defun alexott/gen-cmake-debug-compile-string ()
;; ;;   "Generates compile string for compiling CMake project in debug mode"
;; ;;   (let* ((current-dir (file-name-directory
;; ;;                        (or (buffer-file-name (current-buffer)) default-directory)))
;; ;;          (prj (ede-current-project current-dir))
;; ;;          (root-dir (ede-project-root-directory prj))
;; ;;          (subdir "")
;; ;;          )
;; ;;     (when (string-match root-dir current-dir)
;; ;;       (setf subdir (substring current-dir (match-end 0))))
;; ;;     (concat "cd " root-dir "Debug/" "; make -j3")))


;; ;; ;; JAVA SUPPORT

;; ;; (require 'semantic/db-javap)




;; ;; ;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ;; ;; +++++++++++++++++++++++++++ GLOBAL KEYS ++++++++++++++++++++++++++++++
;; ;; ;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; ;; (global-set-key [(control return)] 'semantic-ia-complete-symbol)
;; ;; ;; (global-set-key "\C-c?" 'semantic-ia-complete-symbol-menu)
;; ;; ;; (global-set-key "\C-c>" 'semantic-complete-analyze-inline)
;; ;; ;; (global-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)



;; ;; ;; bind eassist-list-message
;; ;; (global-set-key (kbd "C-x x h") 'semantic-analyze-proto-impl-toggle)
;; ;; (global-set-key (kbd "C-x x i") 'semantic-ia-fast-jump)
;; ;; (global-set-key (kbd "C-x x o") 'semantic-mrub-switch-tags)
;; ;; (global-set-key (kbd "C-x x l") 'semantic-decoration-include-visit)

;; ;; (global-set-key (kbd "C-x x f") 'eassist-list-methods)
;; ;; ;; (global-set-key (kbd "C-c s") 'eassist-switch-h-cpp )
;; ;; ;; (global-set-key (kbd "C-c u") 'speedbar-update-contents)
;; ;; ;; (global-set-key (kbd "C-c f") 'speedbar-get-focus)

;; ;; (global-set-key (kbd "C-x x d") 'semantic-ia-show-doc)
;; ;; (global-set-key (kbd "C-x x s") 'semantic-ia-show-summary)
;; ;; (global-set-key (kbd "C-x x <left>") 'semantic-tag-folding-fold-block)
;; ;; (global-set-key (kbd "C-x x <right>") 'semantic-tag-folding-show-block)


;; ;; ;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ;; ;; +++++++++++++++++++++++++ LOCAL HOOKS/KEYS +++++++++++++++++++++++++++
;; ;; ;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


;; ;; ;; GETTING INFORMATION ABOUT TAGS

;; ;; ;; The semantic/ia package provides several commands, that allow to get
;; ;; ;; information about classes, functions & variables (including documentation
;; ;; ;; from Doxygen-style comments). Currently following commands are implemented:

;; ;; ;; semantic-ia-show-doc
;; ;; ;;     shows documentation for function or variable, whose names is under point.
;; ;; ;;     Documentation is shown in separate buffer. For variables this command
;; ;; ;;     shows their declaration, including type of variable, and documentation
;; ;; ;;     string (if it's available). For functions, prototype of the function is
;; ;; ;;     shown, including documentation for arguments and returning value(if
;; ;; ;;     comments are available);

;; ;; ;; semantic-ia-show-summary
;; ;; ;;     shows documentation for name under point, but information is shown in the
;; ;; ;;     mini-buffer, so user will see only variable's declaration or function's
;; ;; ;;    prototype;

;; ;; ;; semantic-ia-describe-class
;; ;; ;;     asks user for a name of the class, and return list of functions &
;; ;; ;;     variables, defined in given class, plus all its parent classes.




;; ;; ;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ;; ;; ++++++++++++++++++++++ LOAD PROJECT FILES ++++++++++++++++++++++++++++
;; ;; ;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; ;; ;; Project files
;; ;; (defun load-project-files (file-list)
;; ;;   (dolist (file file-list)
;; ;;     (load-file (concat project_folder file))))


;; ;; (load-project-files
;; ;;  (directory-files project_folder nil "^\\([^.]\\|\\.[^.]\\|\\.\\..\\)"))

;; ;; ;; CEDET END

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; cedet_config.el ends here
