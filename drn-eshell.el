;;; drn-eshell.el --- EShell Configuration           -*- lexical-binding: t; -*-

;; Copyright (C) 2025  Delon Newman

;; Author: Delon Newman <contact@delonnewman.name>
;; Keywords: lisp, unix, tools,

;; For `eat-eshell-mode'.
(add-hook 'eshell-load-hook #'eat-eshell-mode)

;; For `eat-eshell-visual-command-mode'.
(add-hook 'eshell-load-hook #'eat-eshell-visual-command-mode)

(remove-hook 'eshell-load-hook #'eat-eshell-visual-command-mode)
(remove-hook 'eshell-load-hook #'eat-eshell-mode)
