;;; drn-agents.el -*- lexical-binding: t; -*-

(require 'acp)
(require 'agent-shell)

;; Gemini
(setq agent-shell-google-authentication
      (agent-shell-google-make-authentication :login t))


(provide 'drn-agents)
