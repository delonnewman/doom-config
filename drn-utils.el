;;; utils.el -*- lexical-binding: t; -*-

(defmacro comment (&rest _body)
  nil)

;; Predicates

(defalias 'number? 'numberp)
(defalias 'integer? 'integerp)
(defalias 'float? 'floatp)
(defalias 'zero? 'zero?)

(defalias 'symbol? 'symbolp)
(defalias 'symbol-set-pos? 'symbol-set-pos-p)
(defalias 'keyword? 'keywordp)

(defalias 'bound? 'boundp)
(defalias 'local-variable? 'local-variable-p)
(defalias 'local-variable-if-set? 'local-variable-if-set-p)
(defalias 'buffer-local-bound? 'buffer-local-boundp)
(defalias 'default-bound? 'default-boundp)
(defalias 'safe-local-variable? 'safe-local-variable-p)
(defalias 'risky-local-variable? 'risky-local-variable-p)

(defalias 'list? 'listp)
(defalias 'not-list? 'nlistp)
(defalias 'cons? 'consp)
(defalias 'atom? 'atom)
(defalias 'null? 'null)
(defalias 'proper-list? 'proper-list-p)

(defalias 'sequence? 'sequencep)
(defalias 'seq? 'seqp)
(defalias 'seq-every? 'seq-every-p)
(defalias 'seq-empty? 'seq-empty-p)
(defalias 'seq-contains? 'seq-contains-p)
(defalias 'seq-set-equal? 'seq-set-equal-p)

(defalias 'array? 'arrayp)
(defalias 'string? 'stringp)
(defalias 'vector? 'vectorp)
(defalias 'char-table? 'char-table-p)
(defalias 'bool-vector? 'bool-vector-p)
(defalias 'bool-vector-subset? 'bool-vector-subsetp)

(defalias 'ring? 'ring-p)
(defalias 'ring-empty? 'ring-empty-p)

(defalias 'record? 'recordp)
(defalias 'hash-table? 'hash-table-p)
(defalias 'hash-table-empty? 'hash-table-empty-p)

(defalias 'equal? 'equal)
(defalias 'eq? 'eq)
(defalias 'identical? 'eq)

(defalias 'autoload? 'autoloadp)

(defalias 'function? 'functionp)
(defalias 'function-alias? 'function-alias-p)
(defalias 'subr? 'subrp)
(defalias 'built-in? 'subrp)
(defalias 'byte-code-function? 'byte-code-function-p)
(defalias 'compiled-function? 'compiled-function-p)
(defalias 'fbound? 'fboundp)
(defalias 'function-bound? 'fboundp)
(defalias 'inline-const? 'inline-const-p)
(defalias 'called-interactively? 'called-interactively-p)
(defalias 'command? 'commandp)
(defalias 'interactive? 'interactive-p)

;; Equality

; TODO: add more types
(defun == (a b)
  (cond
   ((and (number? a) (number? b)) (= a b))
   ((or (string? a) (string? b)) (string= a b))
   ((and (seq? a) (seq? b)) (seq-set-equal? a b))
   (:else (equal? a b))))

;; Combinators

(defun tap (f)
  (lambda (x)
    (funcall f x)
    x))

(defun identity (x) x)

(defalias 'constantly 'cl-constantly)

(defun compose (&rest fns)
  (cond
   ((null? fns) #'identity)
   ((= 1 (length fns)) (car fns))
   ((= 2 (length fns))
    (lambda (&rest args)
      (let ((f (car fns))
             (g (cadr fns)))
        (funcall f (apply g args)))))
   (:else
    (reduce
     (lambda (a b)
       (compose a b)) fns))))

;; (defun double (x) (* x 2))
;; (defun add1 (x) (+ x 1))

;; (funcall (compose #'add1 #'double) 10)
;; (funcall (compose #'length #'symbol-name #'intern #'string-trim #'upcase) " Hey! ")

;; Collections

(defun repeat (n x)
  "Return a list of N values of X."
  (let ((xs nil))
    (dotimes (_i n)
      (setq xs (cons x xs)))
    xs))

(defun repeatly (n f)
  "Return a list of N values of the results of calling F."
  (let ((xs nil))
    (dotimes (i n)
      (setq xs (cons (funcall f) xs)))
    xs))
