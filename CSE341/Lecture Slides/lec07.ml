let rec bad_rev xs =
  match xs with
  | [] -> []
  | x :: xs -> bad_rev xs @ [ x ]


let rev xs =
  let rec loop (xs, acc) =
    match xs with
    | [] -> acc
    | x :: xs -> loop (xs, x :: acc)
  in
  loop (xs, [])


exception EmptyList

let hd xs =
  match xs with
  | [] -> raise EmptyList
  | x :: _ -> x


let f xs =
  try 1 + hd xs with
  | EmptyList -> -100


let incr x = x + 1

let dbl x = x * 2

let f_list = [ incr; dbl ]

let rec apply_funcs (fs, x) =
  match fs with
  | [] -> x
  | f :: fs' -> apply_funcs (fs', f x)


let rec incr_n_times (n, x) =
  if n = 0 then
    x
  else
    1 + incr_n_times (n - 1, x)


let rec dbl_n_times (n, x) =
  if n = 0 then
    x
  else
    2 * dbl_n_times (n - 1, x)


let rec tl_n_times (n, xs) =
  if n = 0 then
    xs
  else
    List.tl (tl_n_times (n - 1, xs))


let rec n_times (f, n, x) =
  if n = 0 then
    x
  else
    f (n_times (f, n - 1, x))


let rec map (f, xs) =
  match xs with
  | [] -> []
  | x :: xs' -> f x :: map (f, xs')


let rec n (fs : ('a -> int) list) =
  match fs with
  | [] -> 0
  | f :: fs -> f 1 + n fs


let fs = [ (fun x -> 3); (fun x -> 4) ]
