;;; drn-dashboard.el -*- lexical-binding: t; -*-


(defun drn/dashboard-dandelion-banner ()
  "
      _.--'--._
    .'. ':. ' :'.
   '`' : `. `: ':'
  : : '.'. .'.':.`:
  :' -`= `+ .= - `:
  :.' .'.' :.'.`:':
   : : .:`' .:`.':
    '.: . :`. :.'
      `'--,--'`
          y
         (
          \       _
           \    /`/
     _      |__/:/_
     \`\    |\ :  /
     _\:\_  /\ : /_
     \ : /_/\  :  /
     _\ : /_/ : /`
     \  :  /.'/`
 jgs  `\ :/'/``
`^^`^`^``^^`^^^`^^`^^^`^
")

(setcar +doom-dashboard-functions #'drn/dashboard-dandelion-banner)

(provide 'drn-dashboard)
