# Notes week 3

## Lectures

### Building Compound Types
   * We know base types int, bool, unit, char.
   * We also know some compound types: tupes, lists, options.
   * We will now learn new ways to make new compound types.
   * In any language, there are three kinds of type building blocks:
      + Each of
      + One of
      + Self reference
   * Of these:
      + Tuples are clearly each of
      + Options are one-of
      + Int list contains (int and other list) or nothing.
      + We can of course nest compound types.
   * We will now see *records*, which are a lot like tuples, and *syntactic sugar*.
   * Build our own one-of types, and the connected idea of *pattern matching*.
   * Later in the course, we will see how OOP does one-of types (uses subclasses), very different from functional programming.
   
### Records
   * Syntax example with braces; unordered, shown in alphabetical order.
   * We don't have to declare a record type in advance, contrary to say a class in Java or a struct in C.
   * For getting a field from a record, we do `#fieldname record`.
   * Freudian example with id, ego and superego.
   * Note that these are a lot like tuples. It's like a named tuple in Python.
   * Important syntax decision: access-by-position or access-by-name. For example handling a function's arguments.

### Tuples as syntactic sugar
   * We've already seen how to create pairs and records.
   * A pair **is** just a record with special field names.
   * Tuples are just a different way of writing records of the form {1=.., 2=.., ..., n=..}.
   * In PL speak: "Tuples are just syntactic sugar for records with fields named 1, 2, ... n"
   * We will see many more examples of syntactic sugar:
      + Simplifies understanding the language
      + Simplifies implementing the language.
   * `andalso` and `orelse` are also syntactic sugar for particular if then else statements.

### Datatype Bindings
   * A **datatype** binding adds a new type to the environment, with named *constructors*.
   * Also known as "tagged union".
   * Syntax like `TwoInts(1+2,3+4)` is read as: `TwoInts` is the tag part, `(1+2,3+4)` is the data part.
   * How do we access them? We need to:
     + check what constructor made it
     + extract the data

### Case expressions
   * The *case* keyword allows to distinguish between the various constructors for a datatype.
   * The syntax is case e0 of p1 => e1 | p2 => e2 ... | pn => en.
   * Each pattern is a constructor name with some variables (today).
   * Advantages of this are that: you don't duplicate cases, and you don't forget cases.
