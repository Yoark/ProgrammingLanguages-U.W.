fun is_older (d1 : int * int * int, d2 : int * int * int) =
  if #1 d1 < #1 d2
  then true
  else
      if #1 d1 = #1 d2
      then if #2 d1 < #2 d2
           then true
           else
               if #2 d1 = #2 d2
               then #3 d1 < #3 d2
               else false
      else false

fun number_in_month (dates : (int * int * int) list, month : int) =
  if null dates
  then 0
  else
      if  #2 (hd dates) <> month
      then number_in_month(tl dates, month)
      else 1+number_in_month(tl dates, month)

fun number_in_months (dates:(int*int*int) list, months:int list) =
  if null months
  then 0
  else
      number_in_month(dates, hd months)+number_in_months(dates, tl months)
                                                       (* 4 *)

fun dates_in_month (dates:(int*int*int) list, month:int) =
  if null dates
  then []
  else
      if #2 (hd dates)=month
      then hd dates::dates_in_month(tl dates, month)
      else dates_in_month(tl dates, month)

fun dates_in_months (dates:(int*int*int) list, months:int list) =
  if null months
  then []
  else dates_in_month(dates, hd months) @ dates_in_months(dates, tl months)

fun get_nth (strings:string list, n:int) = (*cut the heads, not worry about too few list*)
  if n = 0
  then ""
  else
      if n = 1
      then hd strings
      else
          get_nth(tl strings, n-1)

fun date_to_string (date:int*int*int) =
  let val months = ["January","February","March","April","May","June","July","August","September","October","November","December"]
  in
      get_nth(months, #2 date)^" "^Int.toString(#3 date)^", "^Int.toString(#1 date)
  end
      (*8th*)
fun number_before_reaching_sum (sum:int, pos:int list) =
  if sum <= 0
  then ~1
  else
      1+number_before_reaching_sum(sum-(hd pos), tl pos)

fun what_month (day:int) =
  let val days = [31,28,31,30,31,30,31,31,30,31,30,31]
  in
      number_before_reaching_sum(day, days)+1
  end

fun month_range (day1:int,day2:int) =
  if day1>day2 then
      []
  else
      what_month(day1)::month_range(day1+1,day2)

fun oldest (dates:(int*int*int) list) =
  if null dates
  then NONE
  else
      let
          fun oldest_nonempty(dates:(int*int*int) list)=
            if null (tl dates)
            then hd dates
            else
                let val tl_ans=oldest_nonempty(tl dates)
                in
                    if is_older(hd dates, tl_ans)
                    then hd dates
                    else tl_ans
                end
      in
          SOME (oldest_nonempty dates)
      end

          (*Challenge Problems*)
  (*fun dates_in_months_challenge (dates:(int*int*int) list,months:int list)=*)
fun remove_dup(xs: int list)=
  let
      fun iter_eq(x:int, xs: int list) =
        if null xs
        then false
        else
            if x<>hd xs
            then iter_eq(x, tl xs)
            else true
  in
      if null xs
      then []
      else
          if null (tl xs)
          then xs
          else
              let val tl_ans=remove_dup(tl xs)
              in
                  if iter_eq(hd xs, tl xs)
                  then tl_ans
                  else hd xs::tl_ans
              end
  end

(*Chanllenge 1*)

fun number_in_months_challenge (dates:(int*int*int) list,months:int list)=
  number_in_months(dates, remove_dup months)

fun dates_in_months_challenge (dates:(int*int*int) list, months:int list)=
  dates_in_months(dates, remove_dup months)

(*Chanllenge 2*)
fun reasonable_date (date:int*int*int) =
  let
          val days1 = [31,29,31,30,31,30,31,31,30,31,30,31]
          val days2 = [31,28,31,30,31,30,31,31,30,31,30,31]
  in
      if #1 date <= 0
      then false
      else
          if (#2 date) < 1 orelse (#2 date) > 12
          then false
          else
              let fun get_nth(days: int list,x:int)=
                    if x = 1
                    then hd days
                    else get_nth(tl days,x-1)
              in
                  if (#1 date mod 400)=0 orelse (#1 date mod 4)=0 andalso (#1 date mod 100<>0)
                  then
                      if (#3 date) < 1 orelse (#3 date)> get_nth(days1, #2 date)
                      then false
                      else true
                  else
                      if (#3 date) < 1 orelse (#3 date)> get_nth(days2, #2 date)
                      then false
                      else true
              end
