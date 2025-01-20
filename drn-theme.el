;;; drn-theme.el --- Theme configuration             -*- lexical-binding: t; -*-

;; Copyright (C) 2025  Delon Newman

;; Author: Delon Newman <contact@delonnewman.name

(defvar drn/dark-theme 'doom-tomorrow-night
  "Sets the theme to use when the UI is in dark mode.")

(defvar drn/light-theme 'doom-tomorrow-day
  "Sets the theme to use when the UI is in light mode.")

;; setup auto-switching between light and dark themes
(defun drn/apply-theme (appearance)
  "Load theme, taking current system APPEARANCE into consideration."
  (mapc #'disable-theme custom-enabled-themes)
  (pcase appearance
    ('light (load-theme drn/light-theme t))
    ('dark (load-theme drn/dark-theme t))))

(add-hook 'ns-system-appearance-change-functions #'drn/apply-theme)
