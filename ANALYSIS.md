# Environments and the Toy Evaluator

## Trace

```lisp
(let ((x 2))
  (let ((f (lambda (y) (+ x y))))
    (let ((x 100))
      (f 1))))
```

The outer let reaches the let case, so eval-let binds x=2 and the env is ((x . 2)).

Then, the middle let evaluates (lambda (y) (+ x y)) in that env. It reaches the lambda case and make-closure returns (:closure (y) (+ x y) ((x . 2))). Then f is bound to that closure.

The inner let adds x=100, which makes env ((x . 100) (f . closure) (x . 2)). (f 1) reaches the function-call case. There, lookup finds the closure for f, the argument 1 is evaluated, and apply-closure runs.

Apply-closure builds ((y . 1) (x . 2)) from the saved env, not the current one. (+ x y) looks up x=2 and y=1, which gives 3.

## Captured environment

The line that captures the defining environment is line 168 in the evaluator, the lambda branch in eval-expr, which calls (make-closure (second expr) (third expr) env). The env passed in this is whatever eval-expr was given when it reached the lambda, and make-closure saves it as the last element of the closure. The environment at the moment it's captured is ((x . 2)), which is the outer let's binding. There is no f because eval-let evaluates the init first and binds f after. There is no y since it only gets bound when the apply-closure runs. The inner x = 100 isn't there either because the let comes after the closure is made.

## Caller's environment

If apply-closure extended the caller's environment instead, the function would look up x where it's being called and not where it was written. At the call (f 1), the inner let has already set x to 100, so the function would see 100 and not the initial 2. This returns 101 instead of 3. The language would then be dynamically scoped because a variable's value depends on where the function is called.

## Why funcall

CLISP is a Lisp-2, which has one namespace for functions and a separate one for variables. (f 1) looks for a function named f, so a function stored in a variable needs funcall, like (funcall f 3) in our P16 case. The toy language is a Lisp-1, with only one namespace for both. Its function-call case evaluates the operator (first expr) with eval-expr, like any other expression, so a variable holding a closure can be called directly.