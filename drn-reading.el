;;; drn-reading.el ---                               -*- lexical-binding: t; -*-

;; Copyright (C) 2025  Delon Newman

;; Author: Delon Newman <contact@delonnewman.name>

(require 'eieio)
(require 'request)

(defvar drn/pub-formats '("PDF" "EPUB"))
(defvar drn/pub-languages '("E"))
(defvar drn/pub-symbols '("g" "wp" "w"))
(defvar drn/pub-url-template "https://b.jw-cdn.org/apis/pub-media/GETPUBMEDIALINKS?issue=%s&output=html&pub=%s&fileformat=%s&alllangs=0&langwritten=%s")

(defun drn/issue (year month)
  (record 'pub/issue year month))

(defun drn/issue-year (issue)
  (aref issue 1))

(defun drn/issue-month (issue)
  (aref issue 2))

(defun drn/issue-string (issue)
  (format "%d%d" (drn/issue-year issue) (drn/issue-month issue)))

(defclass drn/Pub ()
  ((symbol :initarg :symbol
           :type string
           :documentation "The symbol of the publication (see drn/pub-symbols)")
   (lang :initarg :lang
         :type string
         :documentation "A string language code")
   (formats :initarg :formats
            :type list
            :documentation "A list of strings that represent file formats (see drn/pub-formats)"))
  "A publication")

(defun drn/data-url (pub issue)
  (format
   drn/pub-url-template
   (drn/issue-string issue)
   (slot-value pub 'symbol)
   (s-join "%2C" (slot-value pub 'formats))
   (slot-value pub 'lang)))

(setq drn.pub/g-E  (drn/Pub :symbol "g"  :lang "E" :formats '("EPUB" "PDF")))
(setq drn.pub/w-E  (drn/Pub :symbol "w"  :lang "E" :formats '("EPUB" "PDF")))
(setq drn.pub/wp-E (drn/Pub :symbol "wp" :lang "E" :formats '("EPUB" "PDF")))

(defvar drn/wget-path "/opt/homebrew/bin/wget")
(defvar drn/curl-path "/usr/bin/curl")

(defun drn/make-command (name path-var)
  (lambda (url &optional buffer)
    (let ((path (eval path-var))
          (buf (or buffer (generate-new-buffer (concat "*" name " output*")))))
      (message "Running %s %s..." name url)
      (start-process name buf path url)
      (message "Finished %s see results in %s" name (buffer-name buf)))))

(defalias 'drn/wget (drn/make-command "wget" 'drn/wget-path))
(defalias 'drn/curl (drn/make-command "curl" 'drn/curl-path))

(defvar drn/curl-buffer (generate-new-buffer "*curl output*"))

(cl-defun drn/proc-pub-feed (&key data &allow-other-keys)
  (message "Got: %S" (alist-get 'files data)))

(cl-defun drn/fetch-pub-feed (&key pub &key issue)
  (request
    (drn/data-url pub issue)
    :parser 'json-read
    :success #'drn/proc-pub-feed))

(drn/fetch-pub-feed :pub drn.pub/g-E :issue (drn/issue 2024 11))

;; (message "Running %s %s..." "wget" (drn/data-url drn.pub/g-E (drn/issue 2024 11)))
