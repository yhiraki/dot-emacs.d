;;; php_config.el ---
;;
;; Filename: php_config.el
;; Description:
;; Author: Manuel Schneckenreither
;; Maintainer:
;; Created: Sun Oct 12 21:01:25 2014 (+0200)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Tue Jan 14 12:00:39 2020 (+0100)
;;           By: Manuel Schneckenreither
;;     Update #: 29
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
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:

(require 'web-mode)
;; (add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
(setq web-mode-engines-alist
      '( ;; ("php"    . "\\.phtml\\'")
        ("blade"  . "\\.blade\\."))
      )


;; Create and set tags table
(defun make-php-tags ()
  "This function reloads the tags by using the command 'make tags'."
  (interactive)
  (let ((dir (nth 0 (if (string-match "app/" default-directory)
                        (split-string default-directory "app")
                      (if (string-match "src/" default-directory)
                          (split-string default-directory "src")
                        (if (string-match "config/" default-directory)
                            (split-string default-directory "config")
                          (if (string-match "resources/" default-directory)
                              (split-string default-directory "resources")
                            (if (string-match "examples/" default-directory)
                                (split-string default-directory "examples/")
                              (split-string default-directory "test")))))))))
    (setq esdir (replace-regexp-in-string " " "\\\\ " dir))
    ;; (let ((dir (nth 0 (split-string default-directory "src"))))
    (setq esdir (replace-regexp-in-string " " "\\\\ " dir))
    (shell-command
     (concat "cd " esdir " && find . -name \"*.php\" -not -name \".#*\" | etags - 1>/dev/null 2>/dev/null") nil)
    (message (concat "cd " esdir " && find . -name \"*.php\" -not -name \".#*\" "
                     "| etags - 1>/dev/null 2>/dev/null") nil)
    (visit-tags-table (concat dir "TAGS"))))


;; PHP MODE
(defun my-php-mode-hook ()


  ;; ;; add auto-complete mode
  ;; (add-to-list 'ac-sources 'ac-source-semantic) ;; slows down auto complete)
  ;; (add-to-list 'ac-sources 'ac-source-abbrev)
  ;; ;; (add-to-list 'ac-sources 'ac-source-css-property)
  ;; (add-to-list 'ac-sources 'ac-source-dictionary)
  ;; ;; (add-to-list 'ac-sources 'ac-source-eclim)
  ;; (add-to-list 'ac-sources 'ac-source-yasnippet)
  ;; ;; (add-to-list 'ac-sources 'ac-source-c-headers)
  ;; ;; (add-to-list 'ac-sources 'ac-source-symbols)
  ;; ;; (add-to-list 'ac-sources 'ac-source-filename)
  ;; ;; (add-to-list 'ac-sources 'ac-source-files-in-current-dir)
  ;; ;; (add-to-list 'ac-sources 'ac-source-gtags)
  ;; (add-to-list 'ac-sources 'ac-source-etags)
  ;; (add-to-list 'ac-sources 'ac-source-imenu)


  ;; ;; (add-to-list 'ac-sources 'ac-source-semantic-raw) ;; slows down auto complete)
  ;; ;; (add-to-list 'ac-sources 'ac-source-words-in-all-buffer)
  ;; ;; (add-to-list 'ac-sources 'ac-source-words-in-buffer)
  ;; ;; (add-to-list 'ac-sources 'ac-source-words-in-same-mode-buffers)


  ;; ;; enable semantic for auto complete mode
  ;; (semantic-mode t)

  ;; ;; enable auto completion. If it doesn't work try to disable flyspell mode.
  ;; (auto-complete-mode)
  (company-mode)


  ;; use programming flyspell mode
  (flyspell-prog-mode)

  (add-hook 'after-save-hook 'make-php-tags nil t)
  (remove-hook 'after-save-hook 'make-c-tags t)

  (setq phanDir (nth 0 (if (string-match "app/" default-directory)
                           (split-string default-directory "app")
                         (if (string-match "src/" default-directory)
                             (split-string default-directory "src")
                           (if (string-match "config/" default-directory)
                               (split-string default-directory "config")
                             (if (string-match "resources/" default-directory)
                                 (split-string default-directory "resources")
                               (if (string-match "examples/" default-directory)
                                   (split-string default-directory "examples/")
                                 (split-string default-directory "test"))))))))

  )

;; add hook
(add-hook 'php-mode-hook 'my-php-mode-hook)


;; flycheck for phan
(require 'flycheck)
;; (require 'phan)

(defvar phan-flycheck-directory ""
  "The direcotry to use to run PHAN in flycheck.")

(setq phanDir "/dev/null")

(flycheck-define-checker php-phan
  "A PHP statical analyzer using phan.
See URL `https://github.com/etsy/phan'."
  :command ("php" (eval (concat phanDir "/vendor/phan/phan/phan")) "--directory" (eval phanDir))
  :error-patterns ((info line-start (file-name) ":" line " " (message) line-end))
  :modes (php-mode))

(flycheck-add-next-checker 'php '(info . php-phan))
(add-to-list 'flycheck-checker 'php-phan)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; php_config.el ends here
