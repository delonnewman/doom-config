;;; perl.el -*- lexical-binding: t; -*-
;;; see https://www.emacswiki.org/emacs/CPerlMode

(def-project-mode! +web-mojo-mode
  :modes '(web-mode cperl-mode)
  :files (or "cpanfile" "lib/" "templates/")
  :match ".*\\.pl"
  :on-enter
  (when (eq major-mode 'web-mode)
    (web-mode-set-engine "mojolicious")))

(after! cperl-mode
  (fset 'perl-mode 'cperl-mode)
  (setq cperl-indent-level 2)
  (setq cperl-indent-parens-as-block t)
  (setq cperl-close-paren-offset (- cperl-indent-level))
  (add-to-list 'auto-mode-alist '("\\.t$" . cperl-mode))
  (add-to-list 'auto-mode-alist '("cpanfile" . cperl-mode)))

(after! flycheck
  (add-hook 'cperl-mode-hook 'flycheck-mode)
  (setq flycheck-check-syntax-automatically '(idle-change save mode-enabled))
  (setq flycheck-display-errors-delay 0.3))

(after! lsp-mode
  (add-to-list 'lsp-language-id-configuration '(".*\\.ep$" . "html"))
  (add-hook 'cperl-mode-hook 'lsp-mode)) ;; TODO: figure out how to configure PERL5LIB

;; Mojolicious
(after! web-mode
  (add-to-list 'auto-mode-alist '("\\.html.ep" . web-mode))
  (add-to-list 'web-mode-engines-alist '("mojolicious" . "\\.ep")))

;; (set-docsets! 'cperl-mode "Perl" "HTML" "CSS" "HTTP" "Bootstrap_5" "C" "Sass")

;; see https://github.com/tree-sitter-perl/tree-sitter-perl
;; (setq treesit-language-source-alist
;;   '((perl . ("https://github.com/tree-sitter-perl/tree-sitter-perl" "release"))))
;; (treesit-install-language-grammar 'perl)

(provide 'drn-perl)
