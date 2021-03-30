use "hw2.sml";

val test1a_1 = all_except_option("a", ["a","b","c","a","d","e","a"]) = SOME ["b","c","d","e"];
val test1a_2 = all_except_option("a", ["b","c","a","d","e","a"]) = SOME ["b","c","d","e"];
val test1a_3 = all_except_option("a", ["b", "c", "d", "e"]) = NONE;

val test1a2_1 = all_except_option2("a", ["a","b","c","a","d","e","a"]) = SOME ["b","c","d","e"];
val test1a2_2 = all_except_option2("a", ["b","c","a","d","e","a"]) = SOME ["b","c","d","e"];
val test1a2_3 = all_except_option2("a", ["b", "c", "d", "e"]) = NONE;

(* try to remove one occurrence of x from xs
   and return a pair (remainder, flag), where
   flag is true if an occurrence of x was removed *)
fun remove (x, xs) =
    let fun aux (x, xs, acc) =
	case xs of
	    [] => (acc, false)
	  | x' :: xs' => if x = x' then (acc @ xs', true) else aux(x, xs', x' :: acc)
    in
	aux(x, xs, [])
    end;

(* check if xs and ys have the same content:
   attempt to remove the head of xs from ys, and recurse *)
fun same_content (xs, ys) =
    case xs of
	[] => ys = []
      | x :: xs' => let val (ys', contains) = remove(x, ys)
		    in
		       contains andalso same_content(xs', ys')
		    end;

val l1 =  [["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]];
val l2 = [["Fred", "Fredrick"], ["Jeff", "Jeffrey"], ["Geoff", "Jeff", "Jeffrey"]]
val test1b_1 = same_content(get_substitutions1(l1, "Fred"), ["Fredrick", "Freddie", "F"]);
val test1b_2 = same_content(get_substitutions1(l2, "Jeff"), ["Jeffrey", "Geoff", "Jeffrey"]);

val test1c_1 = same_content(get_substitutions2(l1, "Fred"), ["Fredrick", "Freddie", "F"]);
val test1c_2 = same_content(get_substitutions2(l2, "Jeff"), ["Jeffrey", "Geoff", "Jeffrey"]);


val test1d_1 = same_content(
	similar_names(l1, {first="Fred", middle="W", last="Smith"}), [{first="Fred",last="Smith",middle="W"},
   {first="Freddie",last="Smith",middle="W"},
   {first="F",last="Smith",middle="W"},
   {first="Fredrick",last="Smith",middle="W"}]);
val test1d_2 = same_content(similar_names(l2, {first="Jeff", middle="W", last="Smith"}), [{first="Jeff",last="Smith",middle="W"},
   {first="Jeffrey",last="Smith",middle="W"},
   {first="Geoff",last="Smith",middle="W"},
   {first="Jeffrey",last="Smith",middle="W"}]);
