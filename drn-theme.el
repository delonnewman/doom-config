;;; drn-theme.el --- Theme configuration             -*- lexical-binding: t; -*-

;; Copyright (C) 2025  Delon Newman

;; Author: Delon Newman <contact@delonnewman.name

(defvar drn/dark-theme 'modus-vivendi
  "Sets the theme to use when the UI is in dark mode.")

(defvar drn/light-theme 'modus-operandi
  "Sets the theme to use when the UI is in light mode.")

(setq modus-themes-mode-line '(borderless))

(setq doom-theme drn/light-theme)

(defun drn/load-theme (theme)
  (setq doom-theme theme)
  (load-theme theme t))

;; setup auto-switching between light and dark themes
(defun drn/apply-theme (appearance)
  "Load theme, taking current system APPEARANCE into consideration."
  (mapc #'disable-theme custom-enabled-themes)
  (pcase appearance
    ('light (drn/load-theme drn/light-theme))
    ('dark (drn/load-theme drn/dark-theme))))

(add-hook 'ns-system-appearance-change-functions #'drn/apply-theme)
