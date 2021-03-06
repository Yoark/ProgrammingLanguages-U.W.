(* Homework2 Simple Test *)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)

val test1 = all_except_option ("string", ["string"]) = SOME []
val test1.2 = all_except_option ("string",[]) = NONE
val test1.3 = all_except_option ("string",["saf"]) = NONE
val test1.4 = all_except_option("string",["asf","string","faasf"]) = SOME ["asf","faasf"]
val test2 = get_substitutions1 ([["foo"],["there"]], "foo") = []
val test2.1 = get_substitutions1([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]], "Jeff") = ["Jeffrey","Geoff","Jeffrey"];
val test3 = get_substitutions2 ([["foo"],["there"]], "foo") = []

val test4 = similar_names ([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], {first="Fred", middle="W", last="Smith"}) =
	    [{first="Fred", last="Smith", middle="W"}, {first="Fredrick", last="Smith", middle="W"},
	     {first="Freddie", last="Smith", middle="W"}, {first="F", last="Smith", middle="W"}]

val test5 = card_color (Clubs, Num 2) = Black

val test6 = card_value (Clubs, Num 2) = 2

val test7 = remove_card ([(Hearts, Ace)], (Hearts, Ace), IllegalMove) = []

val test8 = all_same_color [(Hearts, Ace), (Hearts, Ace)] = true

val test9 = sum_cards [(Clubs, Num 2),(Clubs, Num 2)] = 4

val test10 = score ([(Hearts, Num 2),(Clubs, Num 4)],10) = 4

val test11 = officiate ([(Hearts, Num 2),(Clubs, Num 4)],[Draw], 15) = 6

val test12 = officiate ([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)],
                        [Draw,Draw,Draw,Draw,Draw],
                        42)
             = 3

val test13 = ((officiate([(Clubs,Jack),(Spades,Num(8))],
                         [Draw,Discard(Hearts,Jack)],
                         42);
               false) 
              handle IllegalMove => true)
             
             
fun card_value2(x)=
  case x of
      (_,Num n) => n
    | (_, Ace) => 1
    | _ => 10

fun sum_cards2(cs,v)=
  let fun f (cd,acm)=
        case cd of
            [] => acm
          | x::xs => if v=1
                    then f(xs, card_value2(x)+acm)
                    else f(xs, card_value(x)+acm)
  in f(cs, 0)
  end
      
fun score_challenge(hc, goal)=
  let fun f sum=
         if sum >goal then 3*(sum-goal)
         else goal-sum
  in let val sum1=sum_cards2(hc,1)
     in let val sum2=sum_cards2(hc,11)
        in let val pre = if sum1<sum2 then sum1 else sum2
           in if all_same_color(hc)
              then pre div 2
              else pre
           end
        end
     end
  end
 
fun officiate_challenge(cl,mv,goal)=
  let fun stat(cl,mv,hc)=
        case (cl,mv,hc) of
            (cd,[],hc) => score_challenge(hc,goal)
          | ([],Draw::mv,hc) => score_challenge(hc,goal)
          | (cd,Discard(c)::mv,hc) =>
            stat(cd,mv,remove_card(hc,c,IllegalMove))
          | (c::cd,Draw::mv,hc) => if sum_cards(c::hc) > goal
                                  then score_challenge(c::hc,goal)
                                  else stat(cd,mv,c::hc)
  in stat(cl,mv,[])
  end
