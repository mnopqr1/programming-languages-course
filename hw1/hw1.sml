fun is_older (date1 : int*int*int, date2 : int * int * int) =
    #1 date1 < #1 date2 orelse
    (#1 date1 = #1 date2 andalso
     (#2 date1 < #2 date2 orelse
      (#2 date1 = #2 date2 andalso #3 date1 < #3 date2)));

fun number_in_month (dates : (int*int*int) list, month : int) =
    if null dates
    then 0
    else
	let
	    val head_in_month = if #2 (hd dates) = month then 1 else 0
	in
	    head_in_month + number_in_month(tl dates, month)
	end;

fun number_in_months (dates : (int*int*int) list, months : int list) =
    if null months
    then 0
    else
	number_in_month(dates, hd months) + number_in_months(dates, tl months);

fun dates_in_month (dates : (int*int*int) list, month : int) =
    if null dates
    then []
    else
	let
	    val first = hd dates
	in
	    if #2 first = month
	    then first :: dates_in_month(tl dates, month)
	    else dates_in_month(tl dates, month)
	end;

fun dates_in_months (dates : (int*int*int) list, months : int list) =
    if null months
    then []
    else
	dates_in_month(dates, hd months) @ dates_in_months(dates, tl months);

fun get_nth (strings : string list, n : int) =
    if n = 1
    then hd strings
    else get_nth (tl strings, n - 1);

fun date_to_string(date : int*int*int) =
    let
	val months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    in
	get_nth(months, #2 date) ^ " " ^ Int.toString(#3 date) ^ ", " ^ Int.toString(#1 date)
    end;

fun number_before_reaching_sum(sum : int, ns : int list) =
    if hd ns >= sum
    then 0
    else 1 + number_before_reaching_sum(sum - hd ns, tl ns);

fun what_month(day : int) =
    let
	val lengths = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    in
	1 + number_before_reaching_sum(day, lengths)
    end;


fun month_range(day1 : int, day2 : int) =
    if day1 > day2
    then []
    else
	what_month day1 :: month_range(day1 + 1, day2);

fun oldest(dates : (int*int*int) list) =
    if null dates
    then NONE
    else
	let
	    val oldestintail = oldest(tl dates)
	in
	    if isSome oldestintail andalso is_older(valOf oldestintail, hd dates)
	    then oldestintail
	    else SOME (hd dates)
	end;

