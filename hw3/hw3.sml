(* CSE341, HW3 2019 *)

(* Ex 1-7, paired with Amanda and Hazem *)

val only_lowercase = List.filter (fn x => Char.isLower (String.sub (x, 0)));

fun longest_string1 xs = foldl
			     (fn (x,y) =>
				 if String.size(x) > String.size(y) then x else y)
			     ""
			     xs;

fun longest_string2 xs = foldl
			     (fn (x,y) =>
				 if String.size(x) >= String.size(y) then x else y)
			     ""
			     xs;

fun longest_string_helper f sl =
    List.foldl (fn (x,y) =>
                    if (f (String.size x, String.size y))
                    then x
                    else y
               )
               "" sl

val longest_string3 = longest_string_helper(op>)

val longest_string4 = longest_string_helper(op>=)

val longest_lowercase = longest_string1 o only_lowercase

val caps_no_X_string =
      String.implode
    o (List.filter (fn c => not (c = #"X")))
    o String.explode
    o (String.map Char.toUpper)
	       
				    
exception NoAnswer

fun first_answer_old (f : ('a -> 'b option), li : 'a list) : 'b =
    let
        val answer = ((List.filter isSome) o (List.map f)) li
    in
        if null answer
        then
            raise NoAnswer
        else
            valOf (hd answer)
    end;

fun first_answer f xs =
    case foldl (fn (x, prev) => if (isSome prev) then prev else f x) NONE xs of
	NONE => raise NoAnswer
      | SOME v => v

fun all_answers f xs =
    let fun treat_one (x, acc) =
	    case acc of
		NONE => NONE
	      | SOME ys =>
		case (f x) of
		    NONE => NONE
		  | SOME y => SOME (y @ ys)
    in foldr treat_one (SOME []) xs
    end;

datatype pattern = WildcardP
                 | VariableP of string
                 | UnitP
                 | ConstantP of int
                 | ConstructorP of string * pattern
                 | TupleP of pattern list

datatype valu = Constant of int
              | Unit
              | Constructor of string * valu
              | Tuple of valu list

			      
(* Problem 9 *)
			      
(* g takes three arguments f1 : unit -> int, f2 : string -> int, and p -> pattern. It returns an int. If the pattern p is a wildcard, it returns the int specified by f1. If the pattern p is a variable, it returns the int specified by f2 applied to the variable name. Then recursively for tuples it sums all the values of patterns occurring in the tuple. So g assigns an accumulated value to a pattern, using f1 and f2 for the base case.*)			      
fun g f1 f2 p =
    let 
        val r = g f1 f2 
    in
        case p of
            WildcardP         => f1 ()
          | VariableP x       => f2 x
          | ConstructorP(_,p) => r p
          | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
          | _                 => 0
    end

val count_wildcards = g (fn () => 1) (fn x => 0)

val count_wild_and_variable_lengths =
    g (fn () => 1) (String.size)

fun count_a_var (s, p) = g (fn () => 1) (fn x => if x = s then 1 else 0) p


(* Problem 10 *)

fun variables_in p =
    case p of
	WildcardP => []
      | VariableP x => [x]
      | ConstructorP(_,p) => variables_in p
      | TupleP ps => foldl (fn (p, acc) => (variables_in p) @ acc) [] ps
      | _ => []

fun has_repeats xs =
    case xs of
	[] => false
      | x :: t => List.exists (fn y => y = x) t orelse has_repeats t
								   
fun check_pat p = not (has_repeats (variables_in p))

(* Problem 11 *)		      
		      
fun match (v, p) =
    case p of
        WildcardP => SOME []
      | VariableP s => SOME [(s, v)]
      | UnitP => if v = Unit then SOME [] else NONE
      | ConstantP c => if v = Constant c then SOME [] else NONE
      | ConstructorP (s1, q) => (case v of
				    Constructor (s2, w) => if s1 = s2
							    then match (w, q)
							    else NONE
				  | _ => NONE)
      | TupleP ps            => (case v of
			            Tuple vs => if (length vs = length ps)
				                then all_answers match (ListPair.zip(vs, ps))
				                else NONE
		                  | _ => NONE)

(* Problem 12 *)
fun first_match (v, ps) =
    first_answer (match) (map ( fn p => (v,p) ) ps )

(* don't know how to get handle exception to work :/ ... *)		 
			   
(**** for the challenge problem only ****)

datatype typ = AnythingT
             | UnitT
             | IntT
             | TupleT of typ list
             | DatatypeT of string

(**** you can put all your code here ****)
