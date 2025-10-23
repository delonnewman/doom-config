;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Delon Newman"
      user-mail-address "contact@delonnewman.name")

;; Fonts
(setq doom-font (font-spec :family "JetBrains Mono" :size 14 :weight 'regular)
      doom-variable-pitch-font (font-spec :family "Helvetica Neue" :size 16)
      doom-serif-font (font-spec :family "Palatino" :size 12))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)

;; Org
(setq org-directory "~/Notes/")

;; Frame Title
(setq frame-title-format "%b - Love is as strong as death is")

;; AuthSource
(setq auth-sources '("~/.authinfo"))

;; Enable context menus
(context-menu-mode +1)

;; Enable file and URL references
(global-goto-address-mode)
(ffap-bindings)

;; OS
(setq mac-mouse-wheel-mode t)
(setq mac-mouse-wheel-smooth-scroll t)

(easy-menu-add-item global-map '(menu-bar edit)
                    ["Emoji & Symbols"
                     ns-do-show-character-palette
                     :help "Show macOS Character Palette."
                     :visible (eq window-system 'ns)])

;; Enable Tool Bar
;; (tool-bar-mode t) ;; disable toolbar for now

;; SF Icons
;; (calle24-refresh-appearance)
;; (add-hook 'compilation-mode-hook #'calle24-refresh-appearance)

;; (when (eq window-system 'mac)
;;   (mac-toggle-tab-bar))

;; Reference for defining keybindings
;; https://discourse.doomemacs.org/t/how-to-re-bind-keys/56

;; (add-to-list 'Info-directory-list "/opt/homebrew/Cellar/texinfo/7.2/share/info")
;; (add-to-list 'Info-directory-list "/opt/homebrew/Cellar/make/4.4.1/share/info")
;; (add-to-list 'Info-directory-list "/opt/homebrew/Cellar/bash/5.2.37/share/info")
;; (add-to-list 'Info-directory-list "/opt/homebrew/Cellar/guile/3.0.10/share/info")

(load! "drn-vterm")
(load! "drn-terminal")
(load! "drn-alternate-tool")
(load! "drn-slack")
(load! "drn-emojis")
(load! "drn-tetris")
(load! "drn-projectile")
(load! "drn-theme")
(load! "drn-dashboard")
(load! "drn-elfeed")

(load! "drn-org-mode")

(load! "drn-ruby")
(load! "drn-javascript")
(load! "drn-perl")

;; MacOS / Apple
(load! "applescript")
(load! "apple-music")

;; Services

(prodigy-define-service
  :name "MEPS Translation Projects: Frontend Dev Server"
  :command "npm"
  :cwd "~/Projects/Theocratic/MEPS/meps-translation/packages/tma-frontend-mediacenter-projects"
  :args '("run" "dev:frontend")
  :port 3000
  :tags '(meps node))

(prodigy-define-service
  :name "MEPS Translation Projects: Backend Dev Server"
  :command "npm"
  :cwd "~/Projects/Theocratic/MEPS/meps-translation/packages/tma-frontend-mediacenter-projects"
  :args '("run" "dev:backend")
  :port 3001
  :tags '(meps node))

(prodigy-define-service
  :name "MEPS Translation: Fabric Proxy"
  :command "make"
  :cwd "~/Projects/Theocratic/MEPS/meps-translation/packages/tma-frontend-mediacenter-projects/api/docker"
  :args '("down-proxy" "up-proxy")
  :port 1100
  :tags '(meps docker))

(prodigy-define-service
  :name "Forest"
  :command "make"
  :cwd "~/Projects/Personal/forest"
  :args '("server")
  :port 3000
  :tags '(work perl))
