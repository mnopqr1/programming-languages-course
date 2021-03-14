fun swap(pr : int * bool) =
    (#2 pr, #1 pr);

fun div_mod(x:  int, y: int) =
    (x div y, x mod y);

fun sort_pair(pr : int * int) =
    if (#1 pr) < (#2 pr)
    then pr
    else (#2 pr, #1 pr);
