;;; drn-javascript.el --- JavaScript, TypeScript, etc. Customizations  -*- lexical-binding: t; -*-

;; Copyright (C) 2024  Delon Newman

;; Author: Delon Newman <contact@delonnewman.name>
;; Keywords: tools, languages

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

(require 'tide)
(require 'svelte-mode)
(require 'lsp-mode)

;; (setq drn/enable-prettier '())
;; (after! prettier-js
;;   (when drn/enable-prettier
;;     (eval-after-load 'typescript-mode
;;       '(progn
;;          (add-hook 'web-mode-hook #'add-node-modules-path)
;;          (add-hook 'web-mode-hook #'prettier-js-mode)))
;;     (eval-after-load 'js2-mode
;;       '(progn
;;          (add-hook 'web-mode-hook #'add-node-modules-path)
;;          (add-hook 'web-mode-hook #'prettier-js-mode)))
;;     (eval-after-load 'web-mode
;;       '(progn
;;          (add-hook 'web-mode-hook #'add-node-modules-path)
;;          (add-hook 'web-mode-hook #'prettier-js-mode)))))

(defun setup-tide-mode ()
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (prettier-js-mode +1))

;; Svelte
(add-hook 'svelte-mode-hook #'lsp)
(add-to-list 'auto-mode-alist '("\\.svelte" . svelte-mode))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

;; if you use typescript-mode
(add-hook 'typescript-mode-hook #'setup-tide-mode)
;; if you use treesitter based typescript-ts-mode (emacs 29+)
;; (add-hook 'typescript-ts-mode-hook #'setup-tide-mode)

(provide 'drn-javascript)
;;; drn-javascript.el ends here
