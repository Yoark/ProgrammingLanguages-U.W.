(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)

(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* put your solutions for problem 2 here *)
fun all_except_option (x,xs)=
  case xs of
      [] => NONE
    | s::ss => if same_string(x,s)
              then SOME ss
              else case all_except_option(x,ss) of
                       SOME strings => SOME (s::strings)
                     | NONE => NONE


fun get_substitutions1(subs,s)=
  case subs of
      [] => []
    | x::xs => case all_except_option(s,x) of
                  NONE => get_substitutions1(xs,s)
                | SOME ss => ss @ get_substitutions1(xs,s)

fun get_substitutions2(subs,s)=
  let fun f (subs,s,strings)=
        case subs of
            [] => strings
          | x::xs => case all_except_option(s,x) of
                        NONE => f(xs,s,strings)
                      | SOME ss => f(xs,s,ss@strings)
  in f(subs,s,[])
  end

fun similar_names(lstlst,{first=x,last=y,middle=z})=
  let val sub_value = get_substitutions1(lstlst,x)
  in let fun f(lst)=
         case lst of
             [] => []
          | s::ss => {first=s,last=y,middle=z}::f(ss)
     in {first=x,last=y,middle=z}::f(sub_value)
     end
  end
(*with more efficieny*)
fun similar_names2(lstlst,{first=x,last=y,middle=z})=
  let val sub_value = get_substitutions2(lstlst,x)
  in let fun f(lst, namelst)=
         case lst of
             [] => namelst
          | s::ss => f(ss,{first=s,last=y,middle=z}::namelst)
     in {first=x,last=y,middle=z}::f(sub_value, [])
     end
  end

fun card_color(x)=
  case x of
      (Spades,_) => Black
   |  (Clubs,_) => Black
   |  _ => Red

fun card_value(x)=
  case x of
      (_,Num n) => n
    | (_, Ace) => 11
    | _ => 10
fun remove_card(cs,c,e)=
  case cs of
      [] => raise e
    | x::xs => if x=c
              then xs
              else x::remove_card(xs,c,e)

fun all_same_color(cs)=
  case cs of
      [] => true
    | x::[] => true
    | x::y::xs => card_color(x)=card_color(y) andalso all_same_color(y::xs)

fun sum_cards(cs)=
  let fun f (cd,acm)=
        case cd of
            [] => acm
          | x::xs => f(xs, card_value(x)+acm)
  in f(cs, 0)
  end
      
fun score(hc, goal)=
  let val sum = sum_cards(hc)
  in let val pre = if sum >goal
     then 3*(sum-goal)
     else goal-sum
     in  if all_same_color(hc)
         then pre div 2
         else pre
     end
  end
      
