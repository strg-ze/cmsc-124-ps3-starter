# Reasoning for the Predictions Table

Write one entry under every heading below, then commit this file together with
`predictions.tsv`, before you run a case or open `tests/expected.tsv`.

Each entry names the rule that produces the four predicted fields for that
case. One to three sentences is enough. The grader checks structure only. It
does not judge quality, and it sets no word minimum.

After you run the cases, add a short correction under each case you predicted
wrongly. Say what you predicted, what CLISP printed, and which rule you
misread. Those entries belong in the correction commits.

## P01
The + symbol is considered as a function, so its arguments get evaluated first from left to right, the 1 stays as 1 and the (* 2 3) becomes 6, so it becomes 1 + 6 which is 7. The kind is an integer and since 7 is just a number and not a sequence the length becomes none, then the operator as said earlier is a function.

## P02
The starting element is quote, which is a special operator that returns its argument without evaluating it. That is why the result is a list (+,1,2) and not 3, in which its kind is cons and the length is 3.

## P03
nil evaluates to itself. The kind for it is null, and since it is an atom, there's no head or starting element thus the operator is none. It's also the empty list, so the length is 0.

## P04
t evaluates to itself just like nil. It's an ordinary symbol, not a list, so its kind is symbol and its length is none, and it's also an atom, so there's no head and the operator is none.

## P05
nil is considered a list and a symbol at the same time, so the function symbolp returns t, which is a symbol, and since t is not a sequence the length is none. This doesn't change the kind of nil, which is still null.

## P06
The car function returns the first element of a list and the car of an empty list returns nil instead of returning an error. That rule lets recursions over lists stop cleanly. Then, since it's an empty list, the value is nil, the kind is null, and the length is 0.

## P07
cons is a function that makes a new list that puts its first argument in front of the list in the second argument. That is why it became (1,2,3), then the kind cons, and length 3.

## P08
if evaluates the condition first. (null '()) is true, so only the first branch runs, and 'empty gives the symbol empty, written in lowercase, so the kind is symbol and the length is none. if is special because it never evaluates the other branch.

## P09
and evaluates from left to right and stops at the first nil, returning it. The 1 is true so it keeps going, then it hits nil and stops, so the 3 is never evaluated. The value is nil so the kind is null and the length is 0. PCL calls and a macro, but CLISP also answers yes to special-operator-p that is why it's considered as special-operator.

## P10
defvar makes *ps3-rate* a special (dynamic) variable. Once it's special, the let doesn't create a new private variable, instead, it rebinds the global one while the let body runs. ps3-scale reads *ps3-rate* while that's happening and sees 10, so 3 x 10 = 30, which is an integer so the length is none. The starting element is progn, which is a special operator that evaluates its forms in order and returns the last one's value.

## P11
The manual says definitions return the defined name, so the result is the symbol ps3-twice, so the kind is symbol and the length is none. defun is a macro that expands into lower-level code.

## P12
labels is a special operator that defines local functions that can call themselves. down conses n onto (down (- n 1)) until the base case returns just '(). That gives (cons 3 (cons 2 (cons 1 nil))), which is (3 2 1), so the kind is cons and the length is 3.

## P13
#' is shorthand for (function ...), so #'length passes the length function itself. mapcar is a function that calls it on each element, and the empty list () has length 0, so the result is (2,0,1) with kind cons and length 3.

## P14
Similar to P13 that mapcar calls the function on each element, and mapcar is the head so the operator is function. lambda just creates an anonymous function object without calling it that expands to something like (function (lambda ...)). Then the function just squares each element (* n n) thus (1,4,9) with kind cons and length 3.

## P15
As explained in P14 for the lambda, evaluating it just creates a function object, so the kind is function, and the grader writes every function object as #<function>. A function isn't a sequence, so its length is none, and the manual says that lambda is a macro.

## P16
factor is an ordinary lexical variable. The lambda captures the binding that's visible where it's written, which holds 2. The inner factor 10 is a different variable that lambda never sees, so 3 x 2 = 6, which is an integer so the length is none, and the outermost head is let, a special operator.
