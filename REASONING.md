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
`and` is a special operator that evaluates its arguments from left to right and stops when it encounters nil. Since one of the arguments is nil, evaluation stops immediately and returns nil. The result is the empty list.

## P10
`progn` is a special operator that evaluates its forms in sequence and returns the value of the last one. `defvar` creates a special variable and `defun` defines a function. Because special variables use dynamic scope, the `let` binding is visible during the function call. The function uses the locally bound value instead of the global one and returns a number.

## P11
`defun` is a macro that defines a function. Its value is the function's symbol.

## P12
`labels` is a special operator that allows the local function down to call itself recursively. Starting from 3, each call uses cons to place the current value of n at the front of the list produced by the next call until the base case returns the empty list. The result is a list, so its length is the number of elements in that list.

## P13
`mapcar` is a function that applies a function to each element of a list and collects the results. The length function is applied to each sublist, producing a new list of lengths. The result is a list with the same number of elements as the input list.

## P14
`mapcar` applies the lambda function to every element of the given list. The `lambda` squares each number and returns the result. `mapcar` collects those values into a new list.

## P15
`lambda` is a macro that creates an anonymous function. The function is created but not called, so no multiplication occurs. The result is a function rather than a list or number.

Correction:
Value should be `#<function>` not the function `#(*,n,2)` itself. A misinterpretation of the grader notation.

## P16
`let` creates a variable named factor with the value 2. The `lambda` function is defined while factor is 2, so it remembers that value. When `funcall` calls the function with 3, it multiplies 3 by the captured value of factor and returns a number, so the length is none. This differs from P10, where dynamic scope allows the function to see the newer binding.
