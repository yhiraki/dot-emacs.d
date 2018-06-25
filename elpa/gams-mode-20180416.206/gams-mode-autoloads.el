;;; gams-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "gams-mode" "gams-mode.el" (0 0 0 0))
;;; Generated autoloads from gams-mode.el

(autoload 'gams-mode "gams-mode" "\
Major mode for editing GAMS program file.

The following commands are available in the GAMS mode:

\\{gams-mode-map}

\(fn)" t nil)

(autoload 'gams-view-document "gams-mode" "\
View GAMS manuals.

Envoke the PDF file (or windows help file) viewer and see GAMS
manuals.  The viewer is determined by the variable
`gams-docs-view-program'.  The directory of GAMS documents is
determined by the variable `gams-docs-directory'.  By default,
`gams-docs-directory' is set to `gams-system-directory' + docs.

The list of documents displayed as candidates is created from
GAMS ver 22.5 for windows.  If you use other version of GAMS,
some documents may not be available on you system.

\(fn)" t nil)

(autoload 'gams-lst-mode "gams-mode" "\
Major mode for viewing GAMS LST file.

The following commands are available in the GAMS-LST mode:

\\[gams-lst-view-error]	Jump to the error and show its number and meaning.
\\[gams-lst-jump-to-error-file]	Jump back to the error place in the program file.
\\[gams-lst-jump-to-input-file]	Jump to the input (GMS) file.
\\[gams-lst-kill-buffer]	Close the buffer.
\\[gams-lst-file-summary]	Display Include File Summary.
\\[gams-lst-help]	Display this help.

\\[gams-outline]	Start the GAMS-OUTLINE mode.

\\[gams-lst-solve-summary]/\\[gams-lst-solve-summary-back]	Jump to the next/previous SOLVE SUMMARY.
\\[gams-lst-report-summary]/\\[gams-lst-report-summary-back]	Jump to the next/previous REPORT SUMMARY.
\\[gams-lst-next-var]/\\[gams-lst-previous-var]	Jump to the next/previous VAR entry.
\\[gams-lst-next-equ]/\\[gams-lst-previous-equ]	Jump to the next/previous EQU entry.
\\[gams-lst-next-par]/\\[gams-lst-previous-par]	Jump to the next/previous PARAMETER entry.
\\[gams-lst-next-elt]/\\[gams-lst-previous-elt]	Jump to the next/previous Equation Listing entry.
\\[gams-lst-next-clt]/\\[gams-lst-previous-clt]	Jump to the next/previous Column Listing entry.

\\[gams-lst-query-jump-to-line]	Jump to a line you specify.
\\[gams-lst-jump-to-line]	Jump to a line.

\\[scroll-up]	Scroll up.
\\[scroll-down] or DEL	Scroll down.
\\[gams-lst-widen-window]	Widen the window.
\\[gams-lst-split-window]	Split the window.
\\[gams-lst-move-frame]	Move frame.
\\[gams-lst-resize-frame]	Resize frame.
\\[gams-lst-move-cursor]	Move a cursor to the other window.

\[Commands for Scrolling.]

Suppose that there are two windows displayed like

    __________________
   |		      |
   |  LST buffer 1    |	 ==>  LST-1.
   |		      |
   |  CURSOR  here    |
   |		      |
   |------------------|
   |		      |
   |  LST buffer 2    |	 ==>  LST-2.
   |		      |
   |		      |
    ------------------

\\[gams-lst-scroll-1]/\\[gams-lst-scroll-down-1]		Scroll the current buffer LST-1 up/down one line.
\\[gams-lst-scroll-2]/\\[gams-lst-scroll-down-2]		Scroll the next buffer LST-2 up/down one line.
\\[gams-lst-scroll-double]/\\[gams-lst-scroll-down-double]		Scroll two buffers LST-1 and LST-2 up/down one line.

Keyboard.
  _____________________________________________________________
  |	    |	      |		|	  |	    |	      |
  |    d    |	 f    |	   g	|    h	  |    j    |	 k    |
  |	    |	      |		|	  |	    |	      |
  -------------------------------------------------------------

       |	 |	   |	     |	       |	 |

      UP	DOWN	  UP	    DOWN      UP	DOWN
	 LST-1		     LST-2	       LST-1 & 2

If only one window exists, the above three commands have the same function
i.e. scroll up/down the current buffer.

The followings are page scroll commands.  Just changed to upper case letters.

\\[gams-lst-scroll-page-1]/\\[gams-lst-scroll-page-down-1]	Scroll up/down the current buffer LST-1 by a page.
\\[gams-lst-scroll-page-2]/\\[gams-lst-scroll-page-down-2]	Scroll up/down the next buffer LST-2 by a page.
\\[gams-lst-scroll-page-double]/\\[gams-lst-scroll-page-down-double]	Scroll up/down two buffers LST-1 and LST-2 by a page.

\(fn)" t nil)

(autoload 'gams-model-library "gams-mode" "\
View GAMS model library.

To use this command, you need to set the proper value to the
variable `gams-system-directory'. This command command works only
in GAMS of ver.22.8 or later.

See also the variable `gams-gamslib-command'.

\(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "gams-mode" '("gams-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; gams-mode-autoloads.el ends here
