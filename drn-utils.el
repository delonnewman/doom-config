;;; utils.el -*- lexical-binding: t; -*-

(defmacro comment (&rest body)
  nil)

;; TODO: search-jw-org
(defun open-jw-org ()
  (interactive)
  (browse-url "https://jw.org"))

(defun cowsay ()
  (interactive)
  (let* ((message (read-string "Enter Message: "))
         (buffer (generate-new-buffer "*cowsay*")))
    (set-buffer buffer)
    (insert (shell-command-to-string (format "cowsay %s" message)))
    (switch-to-buffer-other-window buffer)))

(defun github-issues ()
  (interactive)
  (let* ((repo (or (thing-at-point 'word)
                   (read-string "Enter Repo Name: ")))
         (url (format "https://api.github.com/repos/%s/issues" repo))
         (buffer-name (format "*%s-github-issues*" repo))
         (buffer (generate-new-buffer buffer-name)))
    (set-buffer buffer)
    (insert (plz 'get url :as 'string))
    (json-mode)
    (switch-to-buffer-other-window buffer)))
