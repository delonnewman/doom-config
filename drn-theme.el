;;; drn-theme.el --- Theme configuration             -*- lexical-binding: t; -*-

;; Copyright (C) 2025  Delon Newman

;; Author: Delon Newman <contact@delonnewman.name

(defvar drn/dark-theme 'modus-vivendi
  "Sets the theme to use when the UI is in dark mode.")

(defvar drn/light-theme 'modus-operandi
  "Sets the theme to use when the UI is in light mode.")

;; Flagrantly stolen https://emacsredux.com/blog/2025/02/03/clean-unloading-of-emacs-themes/
(defun drn/disable-all-active-themes ()
  "Disable all currently active themes."
  (interactive)
  (dolist (theme custom-enabled-themes)
    (disable-theme theme)))

(defun drn/load-theme (theme)
  (drn/disable-all-active-themes)
  (setq doom-theme theme)
  (load-theme theme t))

(defun drn/load-dark-theme ()
  "Load dark theme configured with drn/dark-theme."
  (interactive)
  (drn/load-theme drn/dark-theme))

(defun drn/load-light-theme ()
  "Load dark theme configured with drn/light-theme."
  (interactive)
  (drn/load-theme drn/light-theme))

(drn/load-theme drn/light-theme)

;; setup auto-switching between light and dark themes
(defun drn/apply-theme (appearance)
  "Load theme, taking current system APPEARANCE into consideration."
  (mapc #'disable-theme custom-enabled-themes)
  (pcase appearance
    ('light (drn/load-theme drn/light-theme))
    ('dark (drn/load-theme drn/dark-theme))))

(add-hook 'ns-system-appearance-change-functions #'drn/apply-theme)
