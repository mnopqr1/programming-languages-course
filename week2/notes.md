# Notes week 2

## Lectures

### ML Variable Bindings and Expressions

* A program is a sequence of bindings, stored in a `.sml`-file.
* The REPL can be used to execute using `use "filename.sml"`.
* You can use earlier things in the sequence, *not* later ones.
* There is a *dynamic environment* in which values of variables get looked up.
* Before running the program, the *static environment* contains the variable types.
* *Syntax* is how you write something
* *Semantics* is what that something means:
  * Type-checking
  * Evaluation

### Rules for Expressions

* For every kind of expression, we can ask three questions:
  1. What is its syntax?
  2. What are the type-checking rules?
  3. What are the evaluation rules?
* We now go through this for various kinds of expressions.
* Variables:
  1. Syntax: sequence of letters, digits, _, but not starting with digit.
  2. Type-checking: look up type in current static environment, if not there, fail.
  3. Evaluation: look up value in current dynamic environment.
* Addition expression:
  1. e1 + e2 where e1 and e2 are expressions.
  2. If e1, e2 both have type int, then e1 + e2 has type int.
  3. If e1 evaluates to v1, e2 evaluates to v2, then e1 + e2 evaluates to v1 + v2.
* Values:
  Evaluate to themselves, can be a number, `true` or `false`, or `()` of type `unit`.
* Conditional expression:
  1. Syntax: if e1 then e2 else e3.
  2. Type-checking: e1 must have type `bool`. e2 and e3 can have any type `t` but it must be the same type.
  3. Evaluation: evaluate e1, if it evaluates to true, the entire expression evaluates to what e2 evaluates to, and otherwise, it evaluates to what e3 evaluates to.

### The REPL and Errors ###

* REPL = Read Eval Print Loop
* Note: always C-d to close REPL and then restart it, if you want to reload a file.
* Errors: it often takes a bit to understand errors, take a while to understand them.
* Tip: M-p gives previous command given to REPL.
* DG gives a demo of how to debug using the REPL, pretty straightforward.
* To get the negative of a value you need to use `~5`, not `-5`.

### Shadowing

* Adding a variable to environment that was already in environment
* Poor style but instructive for understanding how environments work.
* Forward references are not allowed.
* Expressions in variable bindings are evaluated "eagerly".
* There is no assignment, there are just two environments with two different values of a.
* This can be really confusing and this is why we shouldn't do `use` twice in the same REPL session.

### Functions, informally

* The type of a function is written as `fn : int * int -> int`, when it is a function that takes two ints and produces an int.
* You may call a function inside a function itself.
* You cannot refer to later function bindings. For _mutual recursion_ we need something special.
* Power function written with recursion.

### Functions, formally

* The three questions about function bindings:
  * Syntax for now is just `fun x0 (x1 : t1, ..., xn : tn) = e`
  * Evaluation: a function is just a value. It can be called later.
  * Type-checking: `x0` gets the type `t1 * ... * tn -> t`. Type-checker checks the expression `e`, taking into account `x1`, ... `xn` and any environment variables, and then produces (by itself!) a type `t`. We'll see later in the course how the type checking magically does this.
  
* Function calls:
  * Syntax: `e0 (e1, ..., en)` or `e0 e1` if `e0` takes exactly one argument.
  * Type checking: if `e0 (e1, ..., en)` has type `t1 * ... * tn -> t`, then check that each `ei` has type `ti`, and the expression has type `t`.
  * Evaluation: evaluate all the expressions `ei` to `vi`. Extend the environment of `e` by assigning `xi` to `vi`, and then evaluate `e`.

### Pairs and Other Tuples

* Tuples have a fixed number of pieces that may have different types.
* Pairs = 2-tuples.
  * Syntax: `(e1,e2)`.
  * Evaluation: Evaluate both `e1` and `e2`, the result is `(v1,v2)`.
  * Type checking: the product type.
* Accessing a pair: `#1 pr` or `#2 pr`.
* One can just generalize this to more than two parts: arbitrary tuples.
* Pairs and tuples can be nested however you want.

### Lists

* Lists can be arbitrary size but of elements of the same type.
* A useful way to construct lists is **cons**, the notation `::`, adding one value to the beginning of a list.
* Accessing lists:
  * `null e` is true iff `e` evaluates to `[]`
  * `hd e` returns the head,
  * `tl e` return the tail (all values except the first one).
* The type `t list` describes lists containing elements of type t.
* The empty list `[]` has type ` 'a list ` (quote a or alpha).
* The functions null, hd, tl have types that depend on alpha as well.

### List functions

* Pretty much always recursive.
* Various examples in `list_functions.sml`.

### Let expressions

* Local bindings: for style and convenience.
* Syntax: `let b1 b2 ... bn in e end`. Each `bi` is any binding, `e` is any expression.
* Evaluation: evaluate each `bi` and use it to evaluate `e`.
* Type-checking: check types of each `bi` and then check type of `e` in the local environment given by bindings bi.
* Some examples.
* This introduces the idea of **scope**. Variables introduced in a let expression are only in that scope.

### Let expressions and nested functions

* Locally defined functions.
* You can then only use that function in the scope defined by the let expression.
* Limiting the scope is sometimes safe, it cannot be used elsewhere.

### Let and efficiency

* Avoid making recursive calls repeatedly. Use `let` expressions for this.
* Example with a bad vs good version of maximum of a list.
* Save recursive results in local bindings.

### Options

* Allowing to not return a value, a bit analogous to a list.
* `t option` is a type.
* Building: `NONE` or `SOME e`
* Accessing: `isSome` and `valOf`.

### Booleans and Comparisons

* `andalso` and `orelse`: short-circuiting evaluation.
* `not` is just a predefined function.
* Note that these could be defined with if, then, else, but that makes it a bit harder to read.
* Comparison: =, <> for not equal, and >, <, >=, <=.
* Equality comparison cannot be done on `real` numbers.

### Benefits of No Mutation

* It is a **non-feature**: data can never change.
* It avoids problems with shared references.
* There are aliases "under the hood" but we never have to worry about them, handled by compiler.
* By contrast, in Java, it can lead to real security problems because you might inadvertently pass a reference to an access list to an attacker who can then change it - you need to remember to pass a copy of the list instead.

### Pieces of learning a language

* Syntax
* Semantics
* Idioms
* Libraries
* Tools
