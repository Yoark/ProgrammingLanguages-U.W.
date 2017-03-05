fun sum_list (xs : int list)=
  if null xs
  then 0
  else hd xs + sum_list(tl xs)

fun times_list (xs : int list) =
  if null xs
  then 1
  else hd xs * times_list(tl xs)

fun countdown (x : int) =
  if x=0
  then []
  else x :: countdown(x-1)

fun append (xs : int list, ys : int list) =
  if null xs
  then ys
  else (hd xs) :: append((tl xs), ys)

                        (* function over pairs of lists *)
fun sum_pair_list (xs : (int * int) list) =
  if null xs
  then 0
  else #1 (hd xs) + #2 (hd xs) + sum_pair_list(tl xs)

fun factorial (n : int) = times_list(countdown n)

fun firsts (xs : (int * int) list) =
  if null xs
  then []
  else (#1 (hd xs)) :: firsts(tl xs)


fun seconds (xs : (int * int) list) =
  if null xs
  then []
  else (#1 (hd xs)) :: seconds(tl xs)

fun sum_pair_list2 (xs : (int * int) list) =
  (sum_list (firsts xs)) + (sum_list(seconds xs))

                               (* let_expression*)
                               (* lel b1 ... bn in e end *)

fun countup_from1(x : int) =
  let
      fun count (from : int) =
        if from=x
        then x::[]
        else from :: count(from+1)
  in
      count(1)
  end

fun bad_max (xs : int list) =
  if null xs
  then 0
  else if null (tl xs)
  then hd xs
  else if hd xs > bad_max(tl xs)
  then hd xs
  else bad_max(tl xs)

fun good_max (xs : int list) =
  if null xs
  then 0
  else if null (tl xs)
  then hd xs
  else
      let val tl_ans = good_max(tl xs)
      in
          if hd xs > tl_ans
          then hd xs
          else tl_ans
      end
          (* better: returns an int option *)
          (* fn : int list -> int option *)

fun max1 (xs : int list) =
  if null xs
  then NONE
  else
      let val tl_ans = max1(tl xs)
      in if isSome tl_ans andalso valOf tl_ans > hd xs
         then tl_ans
         else SOME (hd xs)
      end

          (* even better because isSome is redundant in most cases as well as valOf of option is too much *)

fun max2 (xs : int list) =
  if null xs
  then NONE
  else let
      fun max_nonempty (xs : int list) =
        if null (tl xs)
        then hd xs
        else let val tl_ans = max_nonempty(tl xs)
             in
                 if hd xs > tl_ans
                 then hd xs
                 else tl_ans
             end
  in
      SOME (max_nonempty xs)
  end
