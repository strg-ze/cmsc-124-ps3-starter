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
`+` is a function, so it evaluates its arguments first. (* 2 3) is evaluated to 6 before + runs, so + gets 1 and 6 and returns 7. 7 is an integer, so the length is none.

## P02
`'` or quote is a special operator that returns its argument untouched so the result is a list rather than the value of (+ 1 2). The length is determined by the number of top-level elements in that list. 

## P03
`nil` evaluates to itself. It represents both the empty list and the false value. Since it is the empty list, its length is 0.

## P04
`t` evaluates to itself and represents true. It is a symbol rather than a list, so the length does not apply.

## P05
`symbolp` is a function that tests whether its argument is a symbol. Since nil is also a symbol in Lisp, the predicate returns a truth value. The result is a symbol, not a list.

## P06
`car` is a function that returns the first element of the list and the quoted empty list evaluates to nil. The length is 0.

## P07
`cons` is a function that constructs a new list by placing its first argument at the front of the second argument. 1 is added to the front of (2 3), creating a list with three elements. The result is a list.

## P08
`if` is a special operator that checks the condition then evaluates the `then-branch` or `if-branch` depending on the result. Since null returns true for an empty list, it evaluates then `then-branch` and returns the symbol `empty`.

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

## P16
`let` creates a variable named factor with the value 2. The `lambda` function is defined while factor is 2, so it remembers that value. When `funcall` calls the function with 3, it multiplies 3 by the captured value of factor and returns a number, so the length is none. This differs from P10, where dynamic scope allows the function to see the newer binding.
