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

;; (after! org
;;   (when window-system
;;     (setq org-hide-emphasis-markers t)
;;     (font-lock-add-keywords 'org-mode
;;                             '(("^ *\\([-]\\) "
;;                                (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
;;     (add-hook 'org-mode-hook
;;               (lambda ()
;;                 (display-line-numbers-mode 0)
;;                 (variable-pitch-mode t)))

;;     (add-hook 'org-mode-hook 'visual-line-mode)

;;     (let* ((variable-tuple
;;             (cond ((x-list-fonts "Palatino")        '(:font "Palatino"))
;;                   ((x-list-fonts "Source Sans Pro") '(:font "Source Sans Pro"))
;;                   ((x-list-fonts "Lucida Grande")   '(:font "Lucida Grande"))
;;                   ((x-list-fonts "Verdana")         '(:font "Verdana"))
;;                   ((x-family-fonts "Sans Serif")    '(:family "Sans Serif"))
;;                   (nil (warn "Cannot find a Sans Serif Font.  Install Source Sans Pro."))))
;;            (base-font-color     (face-foreground 'default nil 'default))
;;            (headline           `(:inherit default :weight bold :foreground ,base-font-color)))

;;       (custom-theme-set-faces
;;        'user
;;        `(org-level-8 ((t (,@headline ,@variable-tuple))))
;;        `(org-level-7 ((t (,@headline ,@variable-tuple))))
;;        `(org-level-6 ((t (,@headline ,@variable-tuple))))
;;        `(org-level-5 ((t (,@headline ,@variable-tuple))))
;;        `(org-level-4 ((t (,@headline ,@variable-tuple :height 1.1))))
;;        `(org-level-3 ((t (,@headline ,@variable-tuple :height 1.25))))
;;        `(org-level-2 ((t (,@headline ,@variable-tuple :height 1.5))))
;;        `(org-level-1 ((t (,@headline ,@variable-tuple :height 1.75))))
;;        `(org-document-title ((t (,@headline ,@variable-tuple :height 2.0 :underline nil))))))

;;     (custom-theme-set-faces
;;      'user
;;      '(org-block ((t (:inherit fixed-pitch))))
;;      '(org-code ((t (:inherit (shadow fixed-pitch)))))
;;      '(org-document-info ((t (:foreground "dark orange"))))
;;      '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
;;      '(org-indent ((t (:inherit (org-hide fixed-pitch)))))
;;      '(org-link ((t (:foreground "royal blue" :underline t))))
;;      '(org-meta-line ((t (:inherit (font-lock-comment-face fixed-pitch)))))
;;      '(org-property-value ((t (:inherit fixed-pitch))) t)
;;      '(org-special-keyword ((t (:inherit (font-lock-comment-face fixed-pitch)))))
;;      '(org-table ((t (:inherit fixed-pitch :foreground "#83a598"))))
;;      '(org-tag ((t (:inherit (shadow fixed-pitch) :weight bold :height 0.8))))
;;      '(org-verbatim ((t (:inherit (shadow fixed-pitch))))))
;;     )
;;   )

;; (use-package! org-bullets
;;   :config
;;   (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(provide 'drn-org-mode)
;;; drn-org-mode.el ends here
