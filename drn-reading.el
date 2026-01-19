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

(defun drn/pub-lang    (pub) (slot-value pub 'lang))
(defun drn/pub-symbol  (pub) (slot-value pub 'symbol))
(defun drn/pub-formats (pub) (slot-value pub 'formats))

(defun drn/pub-lang-symbol (pub)
  (intern (drn/pub-lang pub)))

(defun drn/pub-data-url (pub issue)
  (format
   drn/pub-url-template
   (drn/issue-string issue)
   (drn/pub-symbol pub)
   (s-join "%2C" (drn/pub-formats pub))
   (drn/pub-lang pub)))

(setq drn.pub/g-E  (drn/Pub :symbol "g"  :lang "E" :formats '("EPUB" "PDF")))
(setq drn.pub/w-E  (drn/Pub :symbol "w"  :lang "E" :formats '("EPUB" "PDF")))
(setq drn.pub/wp-E (drn/Pub :symbol "wp" :lang "E" :formats '("EPUB" "PDF")))

;; (drn/pub-data-url drn.pub/g-E (drn/issue 2024 11))

(defvar drn/wget-path "/opt/homebrew/bin/wget")
(defvar drn/curl-path "/usr/bin/curl")

(defun drn/make-command (name path-var)
  (cl-function
   (lambda (url &key buffer &key path)
     (let ((path (eval path-var))
           (buf (or buffer (generate-new-buffer (concat "*" name " output*")))))
       (message "Running %s %s..." name url)
       (start-process name buf path url " --output " path)
       (message "Finished %s see results in %s" name (buffer-name buf))))))

(defalias 'drn/wget (drn/make-command "wget" 'drn/wget-path))
(defalias 'drn/curl (drn/make-command "curl" 'drn/curl-path))

;; (defvar drn/curl-buffer (generate-new-buffer "*curl output*"))

(defun drn/proc-pub-feed (pub)
  (cl-function
   (lambda (&key data &allow-other-keys)
     (let ((files (alist-get (drn/pub-lang-symbol pub) (alist-get 'files data))))
       (let ((urls
              (mapcar
               (lambda (fmt)
                 (alist-get 'url (alist-get 'file (elt (alist-get (intern fmt) files) 0))))
               (drn/pub-formats pub))))
         (message "Got: %S" urls))))))

(cl-defun drn/fetch-pub-feed (&key pub &key issue)
  (request
    (drn/data-url pub issue)
    :parser 'json-read
    :success (drn/proc-pub-feed pub)))

(drn/fetch-pub-feed :pub drn.pub/g-E :issue (drn/issue 2024 11))

;; (message "Running %s %s..." "wget" (drn/data-url drn.pub/g-E (drn/issue 2024 11)))

;; (drn/pub-lang-symbol drn.pub/g-E)
;; (drn/curl "https://cfp2.jw-cdn.org/a/5d85a2/1/o/g_E_202411.pdf" :path "/Users/delonnewman/g_E_202411.pdf")
