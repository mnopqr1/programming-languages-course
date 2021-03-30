use "hw2.sml";

(* these tests does not work yet because no equality defined for json *)
(* 
val test1_1 = make_silly_json(0) = Array [];
val test1_1 = make_silly_json(2) = Array [Object [("n", Num 2.0), ("b", True)], Object [("n", Num 1.0), ("b", True)]];
*)
val test2_1 = assoc(2, [(1,3), (2,4)]) = SOME 4;
val test2_2 = assoc(2, [(1,3), (3,6)]) = NONE;
val test2_3 = assoc(2, []) = NONE;

(*
val test3_1 = dot(Object [("n", Num 2.0), ("b", True)], "n") = Num 2.0;
*)

val test4_1 = one_fields(Object [("n", Num 2.0), ("b", True)]) = ["b", "n"];
val test4_2 = one_fields(Object []) = [];

val test5_1 = no_repeats(["a","b","c"]) = true;
val test5_2 = no_repeats(["a","b","a"]) = false;
val test5_3 = no_repeats([]) = true;
