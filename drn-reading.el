;;; drn-reading.el ---                               -*- lexical-binding: t; -*-

;; Copyright (C) 2025  Delon Newman

;; Author: Delon Newman <contact@delonnewman.name>

(require 'eieio)

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

(defclass <drn/pub> ()
  ((symbol :initarg :symbol
           :type string
           :documentation "The symbol of the publication (see drn/pub-symbols)")
   (lang :initarg :lang
              :type string
              :documentation "A string language code")
   (formats :initarg :formats
            :type list
            :documenation "A list of strings that represent file formats (see drn/pub-formats)"))
  "A publication")

(defun drn/data-url (pub issue)
  (format
   drn/pub-url-template
   (drn/issue-string issue)
   (slot-value pub 'symbol)
   (s-join "%2C" (slot-value pub 'formats))))

(setq drn.pub/g-E (<drn/pub> :symbol "g" :lang "E" :formats '("EPUB" "PDF")))
(setq drn.pub/w-E (<drn/pub> :symbol "w" :lang "E" :formats '("EPUB" "PDF")))
(setq drn.pub/wp-E (<drn/pub> :symbol "wp" :lang "E" :formats '("EPUB" "PDF")))

