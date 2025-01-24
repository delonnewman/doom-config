;;; drn-vscode.el --- Integration with VSCode        -*- lexical-binding: t; -*-

;; Copyright (C) 2024  Delon Newman

;; Author: Delon Newman <contact@delonnewman.name>
;; Keywords: tools, convenience

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;;

;;; Code:

(require 'projectile)

(defvar drn/alternate-tools '())


(defun drn/add-tool (ident name command &optional options)
  "Add tool value to drn/alternate-tools.

A tool is described by it's IDENT a symbol used for
referencing the tool, it's NAME for use in documentation
and a COMMAND string that may have '%s' format variable
placed where a file or project directory should go
when the command is executed. It can also specifiy
an alist of OPTIONS."
  (let ((tool (list name command options)))
    (add-to-list 'drn/alternate-tools (cons ident tool))
    tool))


(defun drn/tool-name (tool)
  "Return a TOOL's name."
  (car tool))


(defun drn/tool-command (tool)
  "Return a TOOL's command."
  (cadr tool))


(defun drn/tool-options (tool)
  "Return a TOOL's options alist."
  (caddr tool))


(defun drn/tool-has? (tool option)
  "Return t if the TOOL has the OPTION given, otherwise return nil."
  (alist-get option (drn/tool-options tool)))

(defalias 'drn/tool-has-p #'drn/tool-has?)


(defun drn/get-tool (ident)
  "Return the tool object associated with this IDENT (see drn/add-tool)."
  (cdr (assoc ident drn/alternate-tools)))


(defun drn/alternate-tool-name (ident)
  "Return the name of the tool associated with this IDENT (see drn/add-tool)."
  (drn/tool-name (drn/get-tool ident)))


(defun drn/alternate-tool-command (ident)
  "Return the command of the tool associated with this IDENT (see drn/add-tool)."
  (drn/tool-command (drn/get-tool ident)))


(defun drn/alternate-tool-has? (ident option)
  "Return t if tool associated with this IDENT has the OPTION, otherwise return nil."
  (drn/tool-has? (drn/get-tool ident) option))

(defalias 'drn/alternate-tool-has-p #'drn/alternate-tool-has?)


(defun drn/current-filename ()
  "Gets the name of the file the current buffer is based on."
  (buffer-file-name (window-buffer (minibuffer-selected-window))))


(defun drn/current-project-path ()
  "Return the path of the current project."
  (if-let ((root (projectile-project-root)))
      root
    (message "Can't locate project root.")))


(defun drn/insert-current-filename ()
  "Insert the current filename in the current buffer."
  (interactive)
  (insert (drn/current-filename)))
(global-set-key (kbd "C-c f") #'drn/insert-current-filename)

(defun drn/open-file-with-command (file command)
  "Open the FILE with COMMAND."
  (let ((buffer-name (concat "*open file with <" command ">*")))
    (start-process-shell-command command buffer-name (format command file))))


(defun drn/open-current-file-with-command (command)
  "Open the current file with COMMAND."
  (interactive "sOpen with command: ")
  (drn/open-file-with-command (drn/current-filename) command))


(defun drn/open-current-project-with-command (command)
  "Open the current project with COMMAND."
  (interactive "sOpen with command: ")
  (drn/open-file-with-command (drn/current-project-path) command))


(defvar drn/vscode-command "code")
(defvar drn/rubymine-command "rubymine")

(defun drn/open-current-file-with-vscode ()
  "Open the current file with Visual Studio Code."
  (interactive)
  (drn/open-current-file-with-command drn/vscode-command))


(defun drn/open-current-file-with-rubymine ()
  "Open the current file with Ruby Mine."
  (interactive)
  (drn/open-current-file-with-command drn/rubymine-command))


(defun drn/open-current-project-with-vscode ()
  "Open the current project in Visual Studio Code."
  (interactive)
  (drn/open-current-project-with-command drn/vscode-command))


(defun drn/open-current-project-with-rubymine ()
  "Open the current project in Ruby Mine."
  (interactive)
  (drn/open-current-project-with-command drn/rubymine-command))


(defun drn/deftool-function-current-file-code (ident)
  "Define a interactive function that calls a tool command identified by IDENT on the current file."
  `(defun ,(make-symbol (concat "drn/open-current-file-with-" (symbol-name ident))) ()
     ,(concat "Open the current file with " (drn/alternate-tool-name ident))
     (interactive)
     (drn/open-file-with-command (drn/current-filename) ,(drn/alternate-tool-command ident))))


(defun drn/deftool-function-current-project-code (ident)
  "Define a interactive function that calls a tool command identified by IDENT on the current project."
  `(defun ,(make-symbol (concat "drn/open-current-project-with-" (symbol-name ident))) ()
     ,(concat "Open the current project with " (drn/alternate-tool-name ident))
     (interactive)
     (drn/open-file-with-command (drn/current-project-path) ,(drn/alternate-tool-command ident))))


(defmacro drn/deftool (ident name command &optional options)
  (let ((tool (drn/add-tool ident name command options)))
    (if (drn/tool-has? tool 'project-only)
        (drn/deftool-function-current-project-code ident)
        `(progn
          ,(drn/deftool-function-current-project-code ident)
          ,(drn/deftool-function-current-file-code ident)))))


;; (macroexpand '(drn/deftool vscode "Visual Studio Code" "code %s"))
;; (progn
;;   (defun drn/open-current-project-with-vscode nil "Open the current project with Visual Studio Code"
;;          (interactive)
;;          (drn/open-file-with-command
;;           (drn/current-project-path)
;;           "code %s"))
;;   (defun drn/open-current-file-with-vscode nil "Open the current file with Visual Studio Code"
;;          (interactive)
;;          (drn/open-file-with-command
;;           (drn/current-filename)
;;           "code %s")))
(define-key doom-leader-open-map (kbd "e v") #'drn/open-current-file-with-vscode)
(define-key doom-leader-open-map (kbd "e p v") #'drn/open-current-project-with-vscode)

;; (macroexpand '(drn/deftool rubymine "RubyMine" "rubymine %s"))
;; (progn
;;   (defun drn/open-current-project-with-rubymine nil "Open the current project with RubyMine"
;;          (interactive)
;;          (drn/open-file-with-command
;;           (drn/current-project-path)
;;           "rubymine %s"))
;;   (defun drn/open-current-file-with-rubymine nil "Open the current file with RubyMine"
;;          (interactive)
;;          (drn/open-file-with-command
;;           (drn/current-filename)
;;           "rubymine %s")))
(define-key doom-leader-open-map (kbd "e r") #'drn/open-current-file-with-rubymine)
(define-key doom-leader-open-map (kbd "e p r") #'drn/open-current-project-with-rubymine)

;; (macroexpand '(drn/deftool xcode "XCode" "open -a XCode %s"))
;; (progn
;;   (defun drn/open-current-project-with-xcode nil "Open the current project with XCode"
;;          (interactive)
;;          (drn/open-file-with-command
;;           (drn/current-project-path)
;;           "open -a XCode %s"))
;;   (defun drn/open-current-file-with-xcode nil "Open the current file with XCode"
;;          (interactive)
;;          (drn/open-file-with-command
;;           (drn/current-filename)
;;           "open -a XCode %s")))
;; (define-key doom-leader-open-map (kbd "e x") #'drn/open-current-file-with-xcode)
;; (define-key doom-leader-open-map (kbd "e p x") #'drn/open-current-project-with-xcode)

;; (macroexpand '(drn/deftool gitup "GitUp" "open -a GitUp %s" '((project-only . t))))
;; (defun drn/open-current-project-with-gitup ()
;;   "Open the current project with GitUp"
;;   (interactive)
;;   (drn/open-file-with-command (drn/current-project-path) "open -a GitUp %s"))
;; (define-key doom-leader-git-map (kbd "v") #'drn/open-current-project-with-gitup)


(provide 'drn-alternate-editor)
;;; drn-alternate-editor.el ends here

