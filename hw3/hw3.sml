(* CSE341, HW3 Provided Code *)

(* Ex 1 *)

val only_lowercase = List.filter (fn x => Char.isLower (String.sub (x, 0)));

fun longest_string1 xs = foldl
			     (fn (x,y) =>
				 if String.size(x) > String.size(y) then x else y)
			     ""
			     xs

fun longest_string2 xs = foldl
			     (fn (x,y) =>
				 if String.size(x) >= String.size(y) then x else y)
			     ""
			     xs

val caps_no_X_string =
    String.implode o (List.filter (fn c => not(c=#"X"))) o String.explode o (String.map Char.toUpper);

						      
			       
				    
exception NoAnswer

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

(**** for the challenge problem only ****)

datatype typ = AnythingT
             | UnitT
             | IntT
             | TupleT of typ list
             | DatatypeT of string

(**** you can put all your code here ****)
