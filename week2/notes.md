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
