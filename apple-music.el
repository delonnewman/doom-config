;;; apple-music.el --- Control Apple Music from Emacs  -*- lexical-binding: t; -*-

;; Copyright (C) 2024  Delon Newman

;; Author: Delon Newman <contact@delonnewman.name>
;; Keywords: multimedia
;;

;;; Code:

(require 'applescript)

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

(provide 'apple-music)
