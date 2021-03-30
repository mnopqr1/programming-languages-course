(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)

fun all_except_list (x : string, ys : string list) =
    case ys of
	[] => []
      | y :: ys' => if same_string(x,y)
		    then all_except_list(x, ys')
		    else y :: all_except_list(x, ys');

fun all_except_option (x : string, ys : string list) =
    case ys of
	[] => NONE
      | y :: ys' => if same_string(x,y)
		    then SOME (all_except_list(x, ys))
		    else case all_except_option(x, ys') of
			     NONE => NONE
			   | SOME l => SOME (y :: l);

fun all_except_option2 (x : string, ys : string list) =
    case ys of
	[] => NONE
      | y :: ys' => case all_except_option2 (x, ys') of 
			NONE => if same_string(x, y) (* if x does not occur in tail, *) 
				then SOME ys'        (* if x = y then return the entire tail *)
				else NONE            (* otherwise, x doesn't occur at all *)
		      | SOME l => if same_string(x, y) (* if x does occur in tail *)
				  then SOME l   (* we want to return the same if x = y *)
				  else SOME (y :: l); (* or prepend y if it is different from x *)

										    


fun get_substitutions1 (subs : string list list, s : string) =
    case subs of
	[] => []
      | sub :: subs' => case all_except_option2(s, sub) of
			        NONE => get_substitutions1(subs', s)
			      | SOME l => l @ get_substitutions1(subs',s);

fun get_substitutions2 (subs : string list list, s : string) =
    let fun aux (subs : string list list, s : string, acc : string list) =
	    case subs of
		[] => acc
	      | sub :: subs' => case all_except_option2(s, sub) of
				    NONE => aux(subs', s, acc)
				  | SOME l => aux(subs', s, l @ acc)
    in
	aux(subs, s, [])
    end;

fun similar_names (substitutions : string list list, {first=f, middle=m, last=l} ) =
    let fun altfullname (f') =
	    {first=f', middle=m, last=l}
    in
	let fun apply_list (xs) =
		case xs of
		    [] => []
		  | x :: xs' => (altfullname x) :: apply_list (xs')
	in
	    altfullname (f) :: apply_list (get_substitutions2 (substitutions, f))
	end
    end;
	
		  
(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* put your solutions for problem 2 here *)
fun card_color (s, r) =
    case s of
	Clubs => Black
      | Spades => Black
      | Hearts => Red
      | Diamonds => Red;

fun card_value (s, r) =
    case r of
	Num a => a
      | Ace => 11
      | _ => 10;

fun remove_card (cs : card list, c : card, e) =
    let fun aux (cs, c, e, acc) =
	case cs of
	    [] => raise e
	  | c' :: cs' => if c' = c
			 then acc @ cs'
			 else aux(cs', c, e, c' :: acc)
    in
	aux(cs, c, e, [])
    end;
 
			
