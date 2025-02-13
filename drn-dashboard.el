;;; drn-dashboard.el -*- lexical-binding: t; -*-


(defun drn/dashboard-dandelion-banner ()
  "
                                           ∞+           π∞
                                        π     π        ππ         ∞
                                     +               π    ∞      π+π
                                                                   π


                               π+ π                          π
                     π          π √            π
                     ∞πππ      ππ π
                           +           ++ππ     +ππ
                    +π
                  ÷√≠×      ππ  =

                    π= +≈  π
   π                    ≈-π
 ∞≈        +++++×   π     -π
 ππ  +   +++++++++π  π   +π
  π   π    +++++++π ÷   π=
  π +  π   +++++     π ++
   +  ×   ++++++     ≈≈=
   π÷≠ πππ++++++π   ≈+=π
      ππ  π+++++++√π
         + ++÷+ π
           ++ π
          +++
          ++√
         π++
         +++
         ++
        +++
        ++∞
        ++
       +++
"
  )

(setcar +doom-dashboard-functions #'drn/dashboard-dandelion-banner)

(provide 'drn-dashboard)
