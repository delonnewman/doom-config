;;; perl.el -*- lexical-binding: t; -*-
(require 'flycheck)

(fset 'perl-mode 'cperl-mode)

(setq cperl-invalid-face nil)
(setq cperl-indent-level 4)

(setq cperl-indent-parens-as-block t)
(setq cperl-close-paren-offset (- cperl-indent-level))

(setq flycheck-check-syntax-automatically '(idle-change save mode-enabled))
(setq flycheck-display-errors-delay 0.3)

(require 'lsp-mode)
(add-hook 'cperl-mode-hook 'flycheck-mode)
(add-hook 'cperl-mode-hook #'lsp)

(add-to-list 'auto-mode-alist '("\\.t" . cperl-mode))
(add-to-list 'auto-mode-alist '("cpanfile" . cperl-mode))

(set-docsets! 'cperl-mode "Perl" "HTML" "CSS" "HTTP" "Bootstrap_5" "C" "Sass")

;; see https://github.com/tree-sitter-perl/tree-sitter-perl
;; (setq treesit-language-source-alist
;;   '((perl . ("https://github.com/tree-sitter-perl/tree-sitter-perl" "release"))))
;; (treesit-install-language-grammar 'perl)

(provide 'drn-perl)
