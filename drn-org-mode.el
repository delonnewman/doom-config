;;; drn-org-mode.el --- Org Mode Customization -*- lexical-binding: t; -*-

;; Copyright (C) 2024  Delon Newman

;; Author: Delon Newman <contact@delonnewman.name>
;; Keywords: tools

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

(require 'org)

(setq org-hide-emphasis-markers t)
(font-lock-add-keywords 'org-mode
                        '(("^ *\\([-]\\) "
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
(add-hook 'org-mode-hook
          (lambda ()
            (display-line-numbers-mode 0)
            (org-bullets-mode 1)))

(add-hook 'org-mode-hook 'visual-line-mode)


(provide 'drn-org-mode)
;;; drn-org-mode.el ends here
