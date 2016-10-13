;;; wisent-php.el --- Php LALR parser for Emacs

;; Copyright (C) 2008, 2009 Anonymous
;;
;; NOTE: Original author wished to remian anonymous and did not assign copyright
;;       to the FSF.

;; Author: Original code for Java by David Ponce <david@dponce.com>
;; Keywords: syntax

;; This file is not part of GNU Emacs.

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2, or (at
;; your option) any later version.

;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:
;;

;;; Code:

(require 'semantic/wisent)
(require 'wisent-php-wy)
(eval-when-compile
  (require 'semantic/util)
  (require 'semantic/ctxt)
  (require 'semantic/imenu)
  (require 'semantic/senator))

;;;;
;;;; Simple parser error reporting function
;;;;

(defun wisent-php-parse-error (msg)
  "Error reporting function called when a parse error occurs.
MSG is the message string to report."
;;   (let ((error-start (nth 2 wisent-input)))
;;     (if (number-or-marker-p error-start)
;;         (goto-char error-start)))
  (message msg)
  ;;(debug)
  )

;;;;
;;;; Local context
;;;;

(define-mode-local-override semantic-get-local-variables
  php-mode ()
  "Get local values from a specific context.
Parse the current context for `field_declaration' nonterminals to
collect tags, such as local variables or prototypes.
This function override `get-local-variables'.

Add `$this', `static' and `self' if needed"
  (let ((vars nil)
        ;; We want nothing to do with funny syntaxing while doing this.
        (semantic-unmatched-syntax-hook nil))
    (let ((class-tag (semantic-current-tag-of-class 'type)))
      (when class-tag
        (setq vars (append (list
                            (semantic-tag-new-variable "$this" class-tag)
                            (semantic-tag-new-variable "static" class-tag)
                            (semantic-tag-new-variable "self" class-tag))
                           vars))))
    vars))

;;;;
;;;; Member protection
;;;;

(define-mode-local-override semantic-tag-protection
  php-mode (tag &optional parent)
  "Return protection information about TAG with optional parent."
  (let ((type-modifiers (semantic-tag-modifiers tag))
        (protection nil))
    (while (and type-modifiers (not protection))
      (let ((modifier (car type-modifiers)))
        (setq protection
              (cond ((string= "private" modifier)
                     'private)
                    ((string= "protected" modifier)
                     'protected)
                    ((string= "public" modifier)
                     'public)
                    (t nil))))
      (setq type-modifiers (cdr type-modifiers)))
    (or protection 'public)))

;;;;
;;;; Name splitting / unsplitting
;;;;

(define-mode-local-override semantic-analyze-split-name
  php-mode (name)
  "Split a tag NAME into a sequence.
Sometimes NAMES are gathered from the parser that are componded.
In PHP, \"foo\bar\" means :
  \"The class BAR in the namespace FOO.\"
Return the string NAME for no change, or a list if it needs to be split."
  (let ((ans (split-string name (regexp-quote "\\"))))
    (if (= (length ans) 1)
        name
    (delete "" ans))))

(define-mode-local-override semantic-analyze-unsplit-name
  php-mode (namelist)
  "Assemble a NAMELIST into a string representing a compound name.
In PHP, (\"foo\" \"bar\") becomes \"foo\\bar\"."
  (mapconcat 'identity namelist "\\"))

;;;;
;;;; Semantic integration of the Php LALR parser
;;;;

;;;###autoload
(defun wisent-php-default-setup ()
  "Hook run to setup Semantic in `php-mode'.
Use the alternate LALR(1) parser."
  (set (make-local-variable 'wisent-in-php) nil)
  (wisent-php-wy--install-parser)
  (setq
   ;; Lexical analysis
   semantic-lex-number-expression semantic-php-number-regexp
   semantic-lex-analyzer 'wisent-php-lexer
   ;; Parsing
   semantic-tag-expand-function 'wisent-php-expand-tag
   ;; Environment
   semantic-imenu-summary-function 'semantic-format-tag-prototype
   imenu-create-index-function 'semantic-create-imenu-index
   semantic-lex-syntax-modifications '((?\\ "."))
   semantic-type-relation-separator-character '("->" "::" "\\")
   semantic-command-separation-character ";"
   semantic-lex-comment-regex "\\(/\\*\\|//\\|#\\)"
   ;; speedbar and imenu buckets name
   semantic-symbol->name-assoc-list-for-type-parts
   ;; in type parts
   '((type     . "Classes")
     (variable . "Variables")
     (function . "Methods"))
   semantic-symbol->name-assoc-list
   ;; everywhere
   (append semantic-symbol->name-assoc-list-for-type-parts
           '((include  . "Includes")
             (package  . "Package")))
   ;; navigation inside 'type children
   senator-step-at-tag-classes '(function variable)
   ))
  ;; Setup phpdoc stuff
  ;;(semantic-php-doc-setup))

(defun wisent-php-create-merge-alias (tag region)
  "Transform alias TAG into a tag that can be expanded.

REGION is a cons START . END delimiting the definition region of the tag."
  (semantic-tag-new-alias (list (cons (semantic-tag-name tag) region))
                          "alias"
                          (list (semantic-tag-alias-definition tag))))

(defun wisent-php-merge-alias (tag region merge-tag)
  "Merge alias TAG with its REGION into the expandable tag MERGE-TAG."
  (semantic-tag-new-alias (cons (cons (semantic-tag-name tag) region)
                                (semantic-tag-name merge-tag))
                          "alias"
                          (cons (semantic-tag-alias-definition tag)
                                (semantic-tag-alias-definition merge-tag))))

(defun wisent-php-expand-tag-variable (tag)
  "Expand variable TAG into a list of equivalents variable tags.
Expand multiple variable declarations in the same statement, that is
tags of class `variable' whose name is equal to a list of elements of
the form (NAME START . END).  NAME is a variable name.  START and END
are the bounds in the declaration, related to this variable NAME."
  (let ((elts (semantic-tag-name tag))
        elt clone start end xpand)
    ;; There are multiple names in the same variable declaration.
    (when (consp elts)
      (while elts
        ;; For each name element, clone the initial tag and give it
        ;; the name of the element.
        (setq elt   (car elts)
              elts  (cdr elts)
              clone (semantic-tag-clone tag (car elt))
              start (if elts  (cadr elt) (semantic-tag-start tag))
              end   (if xpand (cddr elt) (semantic-tag-end   tag))
              xpand (cons clone xpand))
        ;; Set the bounds of the cloned tag with those of the name
        ;; element.
        (semantic-tag-set-bounds clone start end)))
    xpand))

(defun wisent-php-expand-tag-alias (tag)
  "Expand alias TAG into a list of equivalent alias tags.
Expand multiple alias declaration in the same statement, that is
tags of the class `alias' whose name is equal to a list of
elements of the form (NAME START . END) and definition is a list
of definitions corresponding to name elements.  NAME is a
variable.  START and END are the bounds in the declaration,
related to this variable NAME."
  (let ((names (semantic-tag-name tag))
        (defs (semantic-tag-alias-definition tag))
        xpand '())
    (when (and (listp names) (listp defs))
          (dotimes (i (length names))
            (let* ((elt (nth i names))
                   (def (nth i defs))
                   (name (car elt))
                   (region (cdr elt))
                   (clone (semantic-tag-new-alias name "alias" def))
                   (start (car region))
                   (end (cdr region)))
              (setq xpand (cons clone xpand))
              (semantic-tag-set-bounds clone start end))))
    xpand))

(defun wisent-php-expand-tag (tag)
  "Expand TAG into a list of equivalent tags, or nil.

Expand multiple variable or alias declarations merged into a single tag."
  (cond
   ((eq 'variable (semantic-tag-class tag))
    (wisent-php-expand-tag-variable tag))
   ((eq 'alias (semantic-tag-class tag))
    (wisent-php-expand-tag-alias tag))))

;;;###autoload
(add-hook 'php-mode-hook #'wisent-php-default-setup)

(provide 'wisent-php)

;;; wisent-php.el ends here
