;;; drn-terminal.el --- Customization for Terminal UI -*- lexical-binding: t; -*-

;; Copyright (C) 2024  Delon Newman

;; Author: Delon Newman <contact@delonnewman.name>
;; Keywords: unix, tools

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

(unless (display-graphic-p)
  ;; activate mouse-based scrolling
  (global-set-key (kbd "<mouse-4>") 'scroll-down-line)
  (global-set-key (kbd "<mouse-5>") 'scroll-up-line))

(provide 'drn-terminal)
;;; drn-terminal.el ends here
