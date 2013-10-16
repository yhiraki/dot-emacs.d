;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++ THESAURUS CONFIG ++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; THESAURUS - SYNONYM FINDER
(require 'thesaurus)
(setq thesaurus-bhl-api-key thesaurus_api_key)  ;; from registration


;; KEYS search synonym
(define-key global-map (kbd "C-x x s s") 'thesaurus-choose-synonym-and-replace)
