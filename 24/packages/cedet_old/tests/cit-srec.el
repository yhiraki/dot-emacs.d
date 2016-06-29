;;; cit-srec.el --- Test SRecode template mapping and such.

;; Copyright (C) 2008, 2013 Eric M. Ludlam

;; Author: Eric M. Ludlam <eric@siege-engine.com>

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
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:
;;
;; SRecode Testing

;;; Code:

(defun cit-srecode-map-test ()
  "Test SRecode MAP path testintg."
  (interactive)

  (let ((extradir cit-src-dir)
	(oldpath srecode-map-load-path)
	(tmpbuff (get-buffer-create "proj-test")))
    (add-to-list 'srecode-map-load-path extradir)
    (srecode-map-update-map t)

    (srecode-load-tables-for-mode 'c++-mode)
    (srecode-load-tables-for-mode 'c++-mode 'cit-test)

    (unwind-protect
	(let (tmpl1 tmpl2)
	  ;; Test that a new template was detected
	  (when (not (srecode-template-get-table (srecode-table 'c++-mode)
						 "cit-test-template"
						 "test"
						 'cit-test
						 ))
	    (error "Failed to find augmented template"))

	  ;; Test the project distinction template.
	  (save-excursion
	    (set-buffer tmpbuff)

	    ;; Ok, this restricts us to testing on unix...
	    (setq default-directory "/usr/local")
	    (setq tmpl1 (srecode-template-get-table (srecode-table 'c++-mode)
						    "cit-project-template"
						    "test"
						    'cit-test
						    ))

	    (setq default-directory "/tmp/test")
	    (setq tmpl2 (srecode-template-get-table (srecode-table 'c++-mode)
						    "cit-project-template"
						    "test"
						    'cit-test
						    ))

	    (when (eq tmpl1 tmpl2)
	      (error "Failed to differentiate between Project and Non-Project templates"))

	    (when (not (string= (nth 1 (oref tmpl1 :code))
				"THIS IS NOT IN A PROJECT"))
	      (error "Failed to get the correct text for non-project template."))

	    (when (not (string= (nth 1 (oref tmpl2 :code))
				"THIS FILE IS IN /tmp"))
	      (error "Failed to get the correct text for-project template."))
	    ))

      ;; Get rid of our adaptation.  Double check.
      (setq srecode-map-load-path oldpath)
      (srecode-map-update-map t))

;; This would be nice, but I'd have to purge and rebuild the table.
;; to do it, which is a waste for a feature few would ever need.
;;
;;    (when (srecode-template-get-table (srecode-table 'c++-mode)
;;				      "cit-test-template"
;;				      "test"
;;				      'cit-test
;;				      )
;;      (error "Failed to unload augmented template"))

    ))


(provide 'cit-srec)
;;; cit-srec.el ends here
