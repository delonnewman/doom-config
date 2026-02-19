;;; apple-music.el --- Control Apple Music from Emacs  -*- lexical-binding: t; -*-

;; Copyright (C) 2024  Delon Newman

;; Author: Delon Newman <contact@delonnewman.name>
;; Keywords: multimedia
;;

;;; Code:

(defun apple-music-open ()
  "Open Apple Music."
  (interactive)
  (applescript (tell (application "Music") (activate))))


(cl-defun apple-music-play (&optional specifier &key shuffle)
  "Play music in Apple Music. Play the music specified by SPECIFIER if provided.
If SHUFFLE is non-nil the music will play in suffle mode."
  (interactive "sPlay: ")
  (applescript-eval
   `(tell (application "Music")
     (activate)
     ,(when shuffle '(set shuffle-enabled t))
     ,(if specifier `(play ,specifier) '(play)))))


(defun apple-music-pause ()
  "Pause music playing in Apple Music."
  (interactive)
  (applescript (tell (application "Music") (activate) (pause))))


(defun apple-reminders-open ()
  "Open Apple Reminders."
  (interactive)
  (applescript
   (tell (application "Reminders")
     (activate))))

(defun jw-library-open ()
  "Open JW Library."
  (interactive)
  (applescript (tell (application "JW Library") (activate))))

(defun apple-podcasts-open ()
  "Open Apple Podcasts."
  (interactive)
  (applescript (tell (application "Podcasts") (activate))))

;; tell application "System Events"
;;   tell process "JW Library"
;;     set frontmost to true
;;     click menu item "Move to Built-in Retina Display" of menu "Window" of menu bar 1
;;     click menu item "Enter Full Screen" of menu "View" of menu bar 1
;;   end tell
;; end tell

;; (defun move-application-to-extra-display (application)
;;   (applescript-eval
;;    `(tell (application "System Events")
;;      (tell (process ,application)
;;       (set frontmost t)
;;       (click-menu-item "Move to Built-in Retina Display" :of-menu "Window" :of-menu-bar 1))))
;;   )

(provide 'apple-music)
