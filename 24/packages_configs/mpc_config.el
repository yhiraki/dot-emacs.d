;;; mpc_config.el ---
;;
;; Filename: mpc.config.el
;; Description:
;; Author: Manuel Schneckenreither
;; Maintainer:
;; Created: Mo Apr 14 17:47:32 2014 (+0200)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Di Apr 15 11:48:05 2014 (+0200)
;;           By: Manuel Schneckenreither
;;     Update #: 15
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


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++ MPC Music Client ++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


;; start mpd server (nil means hide output)
(start-process "mpd-service" nil "mpd")

(require 'mpc)

;; this function is not defined by default anymore
(defun mpc-cmd-status ()
  (mpc-proc-cmd-to-alist "status"))

;; toggle play/pause
(defun mpc-toggle-pause ()
  "This function checks the current status of mpc. If it is in
pause state, it will start playing, and vice versa."
  (interactive)
  (if (member (cdr (assq 'state (mpc-cmd-status))) '("play"))
      (mpc-pause)
    (mpc-play)))

;; set keys
(global-set-key (kbd (concat prefix-command-key "m p")) 'mpc-toggle-pause)
(global-set-key (kbd (concat prefix-command-key "m s")) 'mpc)
(global-set-key (kbd (concat prefix-command-key "m f")) 'mpc-next)
(global-set-key (kbd (concat prefix-command-key "m b")) 'mpc-prev)


;; set view of play-list
(setq mpc-browser-tags '(Artist Album)
      mpc-songs-format "%3{Track} | %25{Title} | %20{Album} | %20{Artist} | %-5{Time} | %10{Date}")
