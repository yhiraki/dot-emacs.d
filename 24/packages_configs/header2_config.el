
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++ HEADER 2 CONFIG +++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


;; AUTOMATIC INSTERT HEADER ON FILE SAVE
(require 'header2)
(add-hook 'write-file-hooks 'auto-update-file-header)
