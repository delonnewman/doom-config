;;; magbot.el --- For fetching media from jw.org feeds  -*- lexical-binding: t; -*-

;; Copyright (C) 2023  Delon Newman

;; Author: Delon Newman <contact@delonnewman.name>
;; Keywords: news, convenience
(require 'web)

(let ((url "https://www.jw.org/en/whats-new"))
  (web-http-get
   (lambda (_ _ data)
     (with-current-buffer (get-buffer-create "*jw-org-whats-new*")
       (goto-char (point-max))
       (insert data)))
   :url url))

;; https://www.jw.org/download/?issue=202111&output=html&pub=g&fileformat=PDF%2CEPUB%2CJWPUB%2CRTF%2CTXT%2CBRL%2CBES%2CDAISY&alllangs=0&langwritten=E&txtCMSLang=E&isBible=0
