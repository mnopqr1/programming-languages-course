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

	   
			    
