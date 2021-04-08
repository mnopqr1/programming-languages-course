(* Homework3 Simple Test*)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)

use "hw3.sml";

(* val test1 = only_lowercase ["a","B","c"] = ["a","c"] *)

val test2 = longest_string1 ["A","bc","C"] = "bc"

val test3 = longest_string2 ["A","bc","C"] = "bc"

val test4a = longest_string3 ["A","bc","C"] = "bc"

val test4b = longest_string4 ["A","B","C"] = "C"

val test7 = first_answer (fn x => if x > 3 then SOME x else NONE) [1,2,3,4,5] = 4

val test8 = all_answers (fn x => if x = 1 then SOME [x] else NONE) [2,3,4,5,6,7] = NONE

val test9a = count_wildcards WildcardP = 1

val test9b = count_wild_and_variable_lengths (VariableP("a")) = 1

val test9c = count_a_var ("x", VariableP("x")) = 1

val test9c_2 = count_a_var ("hi", (TupleP [VariableP "hello", VariableP "hi", VariableP "hi"])) = 2						       


val test10 = check_pat (VariableP ("x")) = true

val test11 = match (Constant (1), UnitP) = NONE

val test11_2 = match (Tuple [Constant 1, Constant 2], TupleP [VariableP "u", VariableP "v"]) = SOME [("u",Constant 1),("v",Constant 2)];			       
(*
val test12 = first_match Unit [UnitP] = SOME []
*)
