;;; perl.el -*- lexical-binding: t; -*-
(require 'flycheck)
(require 'lsp-mode)

(fset 'perl-mode 'cperl-mode)

(setq cperl-invalid-face nil)
(setq cperl-indent-level 4)

(setq cperl-indent-parens-as-block t)
(setq cperl-close-paren-offset (- cperl-indent-level))

(setq flycheck-check-syntax-automatically '(idle-change save mode-enabled))
(setq flycheck-display-errors-delay 0.3)

(add-hook 'cperl-mode-hook #'lsp)
(add-hook 'cperl-mode-hook 'flycheck-mode)
(add-to-list 'auto-mode-alist '("\\.t$" . cperl-mode))
(add-to-list 'auto-mode-alist '("cpanfile" . cperl-mode))

;; Mojolicious
(add-to-list 'auto-mode-alist '("\\.ep.*" . web-mode))
(setq web-mode-engines-alist '(("mojolicious"    . "\\.ep.*")))

(set-docsets! 'cperl-mode "Perl" "HTML" "CSS" "HTTP" "Bootstrap_5" "C" "Sass")

;; see https://github.com/tree-sitter-perl/tree-sitter-perl
;; (setq treesit-language-source-alist
;;   '((perl . ("https://github.com/tree-sitter-perl/tree-sitter-perl" "release"))))
;; (treesit-install-language-grammar 'perl)

(provide 'drn-perl)
