(* Coursera Programming Languages, Homework 3, Provided Code *)

exception NoAnswer

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
    let 
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end

(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

(**** you can put all your code here ****)
val only_capitals  = List.filter (fn x => Char.isUpper(String.sub(x,0)))

fun longest_string1 strings =
  List.foldl (fn (a,b) => if String.size a > String.size b
                        then a
                        else b) "" strings

fun longest_string2 strings =
  List.foldl (fn (a,b) => if String.size a >= String.size b
                        then a
                        else b) "" strings

fun longest_string_helper g =
  List.foldl  (fn (a,b) => if g(String.size a, String.size b)
                         then a
                         else b) "" 

val longest_string3 = longest_string_helper (fn (a,b)=> a > b)
val longest_string4 = longest_string_helper (fn (a,b)=> a >= b)
val longest_capitalized = longest_string3 o only_capitals

val rev_string = String.implode o List.rev o String.explode
(*5 lines?*)
fun first_answer g lst=
  case lst of
      [] => raise NoAnswer
    | x::xs => case g x of
                  SOME v => v
               | NONE => first_answer g xs
fun all_answers g lst=
  let fun helper (ls,acc)=
        case ls of
            [] => SOME acc
          | x::xs => case g x of
                        NONE => NONE
                      | SOME v => (helper (xs,v@acc))
  in helper(lst,[]) 
  end

val count_wildcards = g (fn () => 1) (fn x => 0)
val count_wild_and_variable_lengths = g (fn () => 1) (fn s => String.size s)
val count_some_var = fn (str,p) => g (fn () => 0) (fn s => if s=str then 1 else 0) p

fun check_pat p=
  let fun all_strings pa =
	case pa of
	    Variable x        => [x]
	  | TupleP ps         => List.foldl (fn (p,i) => (all_strings p) @ i) [] ps
	  | ConstructorP(_,p) => all_strings p 
          |  _=> []
      fun not_rep strs=
        case strs of
               [] => true
             | x::[] => true
             | x::y::xs =>  List.all (fn a => a<>x) (y::xs) andalso not_rep (y::xs)
  in (not_rep o all_strings) p
  end

fun match (v,p)=
  case (v,p) of
      (_,Wildcard) => SOME []
    | (a,Variable b) => SOME [(b,a)]
    |  (Unit,UnitP) => SOME []
    |  (Const v,ConstP p) => if p=v
                            then SOME []
                            else NONE
    |  (Tuple xs,TupleP ps) => if List.length xs = List.length ps
                              then all_answers match (ListPair.zip (xs,ps))
                              else NONE
    |  (Constructor(s1,v),ConstructorP(s2,p)) => if s1=s2
                                                then match (v,p)
                                                else NONE
    |  _ => NONE

fun first_match v ps=
  SOME (first_answer (fn p => match (v,p)) ps)
  handle NoAnswer => NONE
