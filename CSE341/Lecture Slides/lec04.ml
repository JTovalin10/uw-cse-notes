let a = 1 + 6 in a * a (* evaluates to 49 *)

let b = 3 ;;
let a = 2 + 1 in a * b  ;;

let a = 1 in let c = 2 in a * c 


(*
take a floating point number x and an int n
recursively square x n times, returning a list of all the squares
squaring_sequence(2.0, 3) return [4.; 16.; 256.0]
*)
let rec squaring_sequence ((x : float), (n : int)) : float list =
  if n = 0 then [] else
    let sq = x *. x in
    sq :: squaring_sequence (sq, n - 1)


let nats_upto (x : int) =
  let rec loop (lo : int) =
    if lo < x then
      lo :: loop (lo + 1)
    else []
    in loop 0
  (* let rec range ((lo : int), (hi : int)) =
  if lo < hi then
    lo :: range (lo + 1, hi)
  else []
  in range(0, x) *)

let rec bad_max (xs : int list) : int =
 if xs = [] then
   0 (* bad style, will fix later *)
 else if List.tl xs = [] then
   List.hd xs
 else
  let tl_max = bad_max (List.tl xs) in
  if List.hd xs > tl_max then
    List.hd xs
  else
    tl_max

let rec good_max (xs : int list) =
  if xs = [] then
    None
  else
    let tl_ans = good_max (List.tl xs) in
    if not (tl_ans = None) && Option.get tl_ans > List.hd xs then
      tl_ans
    else 
      Some (List.hd xs)