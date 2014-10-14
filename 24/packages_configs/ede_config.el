;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++ Configuration for EDE project management ++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


(global-ede-mode t)

(require 'cedet)
(require 'eieio)
(require 'eieio-speedbar)
(require 'ede/source)
(require 'ede/base)
(require 'ede/auto)

(load "ede/loaddefs" nil 'nomessage)

(declare-function ede-commit-project "ede/custom")
(declare-function ede-convert-path "ede/files")
(declare-function ede-directory-get-open-project "ede/files")
(declare-function ede-directory-get-toplevel-open-project "ede/files")
(declare-function ede-directory-project-p "ede/files")
(declare-function ede-find-subproject-for-directory "ede/files")
(declare-function ede-project-directory-remove-hash "ede/files")
(declare-function ede-toplevel "ede/base")
(declare-function ede-toplevel-project "ede/files")
(declare-function ede-up-directory "ede/files")
(declare-function semantic-lex-make-spp-table "semantic/lex-spp")

(defconst ede-version "1.2"
  "Current version of the Emacs EDE.")


;; (ede-enable-generic-projects)
