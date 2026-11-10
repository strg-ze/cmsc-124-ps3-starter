;;;; evaluator.lisp -- Part 2. Write the eight functions below.
;;;;
;;;; The toy language is a Lisp-1. One namespace holds both variables and
;;;; functions, so a variable bound to a closure is callable in operator
;;;; position and (f 1) works with no FUNCALL. The CLISP hosting this file is a
;;;; Lisp-2, which is why the host needs FUNCALL and #' where the toy language
;;;; needs neither. ANALYSIS.md asks you about that difference.
;;;;
;;;; An environment is an association list: ((name . value) (name . value) ...).
;;;; The grader scores E1 to E4 separately, so finish them in order and keep
;;;; every group you get right.
;;;;
;;;; The grammar, in full:
;;;;
;;;;   expr := number
;;;;         | symbol
;;;;         | (+ expr expr) | (- expr expr) | (* expr expr)
;;;;         | (let ((name expr) ...) body)
;;;;         | (lambda (name ...) body)
;;;;         | (operator-expr argument-expr ...)

;;; E1 -- numbers and symbols.

(defun lookup (name env)
  "The value NAME is bound to in ENV.

The first match wins, so an inner binding shadows an outer one that shares its
name. Signal an error when NAME is not bound at all."
  (declare (ignore name env))
  (error "lookup is not implemented"))

;;; E2 -- prefix arithmetic.

(defun eval-operands (exprs env)
  "Every expression in EXPRS, evaluated in the same ENV, as a list.

MAPCAR and a LAMBDA do this in one line. Watch the arity: EVAL-EXPR takes two
arguments and MAPCAR hands its function one."
  (declare (ignore exprs env))
  (error "eval-operands is not implemented"))

(defun apply-op (op values)
  "Apply the arithmetic operator OP to the two numbers in VALUES.

OP is the symbol +, -, or *. Signal an error for anything else."
  (declare (ignore op values))
  (error "apply-op is not implemented"))

;;; E3 -- let.

(defun extend-env (params args env)
  "ENV with PARAMS bound to ARGS in front of it.


MAPCAR takes two lists and #'CONS pairs them. Build a new list. Do not modify
ENV, because the caller keeps using it after the extension goes out of scope."

  (append(mapcar #'cons params args) env))
  ;params - names / symbols (x) (y)
  ;args - values attached to names (1) (2)
  ;env - the old environment ((x . 1) (y . 2))
  ; (extend-env '(x y) '(1 2) '((z . 3))) becomes ((x . 1) (y . 2) (z . 3))

(defun eval-let (expr env)
  "Evaluate (let ((name init) ...) body).

Every init is evaluated in ENV before any name is bound, so the bindings happen
in parallel and an init cannot see a name the same LET introduces."

  ;example: (let ((a 10) (b 20))
  ;          (+ a b))

  ;expr - the whole let expression
  ;first expr - the symbol let
  ;second expr - the list of bindings ((a 10) (b 20))
  ;third expr - the body (+ a b)
  
  (let* ((bindings (second expr))
          (body (third expr))
          ;mapcar #'first -> just the names (x y)
          (names (mapcar #'first bindings))
          ;evaluate every init in the old env
          (val (eval-operands (mapcar #'second bindings) env)))
    ;bind the names and run the body
    (eval-expr body (extend-env names val env)))
    )

;;; E4 -- lambda and application.

(defun make-closure (params body env)
  "A closure over ENV.

Return the list (:closure params body env). ENV is the environment the lambda
was written in, not the one it will later be called from. Saving the wrong one
is what makes the difference between 3 and 101 in the case the manual walks
through."
  (list :closure params body env))
  ;:closure - label/keyword so it can be recognized later
  ;params - the parameter names (x)(y)
  ;body - the code (+ x y)
  ;env - the saved variables ((x . 2))

  
(defun apply-closure (closure args)
  "Run CLOSURE on ARGS.

The parameters join the environment the closure captured. Signal an error when
CLOSURE is not a closure, and when the argument count does not match."

  ;check if the given is a closure
  ;consp checks if the closure is a list
  ;eq checks if the first element is :closure
  (unless (and (consp closure) (eq (first closure) :closure))
    (error "not a closure: ~S" closure))

  ;from make-closure, (:closure params body env)
  (let ((params (second closure))
        (body (third closure))
        (saved-env (fourth closure)))
    ;check argument count
    (unless (= (length params) (length args))
      (error "wrong number of arguments"))
    ;run body in the closure's saved environment extended with the new bindings
    (eval-expr body (extend-env params args saved-env))))

;;; The dispatcher.

(defun eval-expr (expr env)
  "The value of EXPR in ENV.

Order the branches with care. NIL is a symbol as well as the empty list, and a
number is not a cons, so the atom tests come before the list tests."

  ;cond checks each branch in order and runs the first one that matches
  (cond
    ;number evaluates to itself
    ((numberp expr) expr)

    ;symbol evaluates to its value in the environment
    ; since nil is a symbol too, this branch comes before the list tests
    ((symbolp expr) (lookup expr env))

    ;evaluate arithmetic expressions
    ;evaluate both operands first, then apply the operator
    ((member (first expr) '(+ - *))
     (apply-op (first expr) (eval-operands (rest expr) env)))

    ;let expression: bind variables and evaluate the body
    ((eq (first expr) 'let)
     (eval-let expr env))

    ;lambda expression: build a closure, saving the CURRENT env
    ((eq (first expr) 'lambda)
     (make-closure (second expr) (third expr) env))

    ;function call: evaluate the operator and arguments, then apply
    ;no funcall is needed since this is lisp-1
    (t
     (apply-closure (eval-expr (first expr) env)
                    (eval-operands (rest expr) env)))))
