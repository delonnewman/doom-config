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

(defvar drn-alternate-editor-key (kbd "&"))

(defun drn-add-alternate-editor (hook command)
  "Add alternate editor.
Do so by specifying a HOOK that should be used to trigger
it's use and the COMMAND to execute."
  (add-hook hook
            (lambda ()
              (local-set-key drn-alternate-editor-key
                             (lambda () (drn-open-current-file-with-command command))))))

(defun drn-current-filename ()
  "Gets the name of the file the current buffer is based on."
  (buffer-file-name (window-buffer (minibuffer-selected-window))))

(defun drn-insert-current-filename ()
  "Insert the current filename in the current buffer."
  (interactive)
  (insert (drn-current-filename)))
(global-set-key (kbd "C-c f") #'drn-insert-current-filename)

(defun drn-open-current-file-with-command (command)
  "Open the current file with COMMAND."
  (interactive "sOpen with command: ")
  (shell-command (concat command " " (drn-current-filename))))

(defun drn-open-current-file-with-vscode ()
  "Open the current file with Visual Studio Code."
  (interactive)
  (drn-open-current-file-with-command "code"))

(defun drn-open-current-file-with-rubymine ()
  "Open the current file with Visual Ruby Mine."
  (interactive)
  (drn-open-current-file-with-command "rubymine"))

(define-key doom-leader-open-map (kbd "e v") #'drn-open-current-file-with-vscode)
(define-key doom-leader-open-map (kbd "e r") #'drn-open-current-file-with-rubymine)

(provide 'drn-alternate-editor)
;;; drn-alternate-editor.el ends here
