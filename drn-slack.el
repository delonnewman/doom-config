;;; drn-slack.el --- Slack Customization -*- lexical-binding: t; -*-

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

(use-package! slack
  :commands (slack-start)
  :init
  (setq slack-buffer-emojify t) ;; if you want to enable emoji, default nil
  (setq slack-prefer-current-team t)
  :config
  (slack-register-team
   :name "Combinaut"
   ;; TODO: secure this info
   :token "xoxc-221900134594-2915347622257-5134063839653-2530012ea8ce2193efdc068e5cb4b63fc396335fac2a353da912cf67ce714502"
   :cookie "xoxd-RAbbmOjT8xKZoigUTFckIPtnRm%2Ftf5qbprZYkKou4Tdea%2FPTlpC%2F2M%2Bxx6tVsbFdCb1OtYLduPgiXEFHrqiyj8awBPxuTI2sUa1EG44wpTX3zPxm%2Bwwr6bVXRMdEKqG5744UYnjFBV%2Ft7kNMFhg7x5SZqTSJ4zBq%2FEZ6zCuLh5QFe2Zl2QibBYpT"
   :subscribed-channels '(atrium atrium-nlp dev-tips internal)
   :full-and-display-names t))

(use-package! alert
  :commands (alert)
  :init
  (setq alert-default-style 'notifier))

(provide 'drn-slack)
;; drn-slack.el ends here
