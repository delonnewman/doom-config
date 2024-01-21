;;; perl.el -*- lexical-binding: t; -*-
(require 'flycheck)

(fset 'perl-mode 'cperl-mode)

(setq cperl-invalid-face nil)
(setq cperl-indent-level 4)

(setq cperl-indent-parens-as-block t)
(setq cperl-close-paren-offset (- cperl-indent-level))

(setq flycheck-check-syntax-automatically '(idle-change save mode-enabled))
(setq flycheck-display-errors-delay 0.3)

(add-hook 'cperl-mode-hook 'flycheck-mode)

(provide 'perl-config)
