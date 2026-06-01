let f : ('a -> 'a) ref = ref (fun x -> x)

let fact n =
  if n = 0 then
    1
  else
    n * !f (n - 1)


let res1 = fact 5 (* 20 *)

let _ = f := fun x -> x * 2

let res2 = fact 5 (* 40 *)

let _ = f := fact

let res3 = fact 5 (* 120 *)

let x = ref 10

let y = ref 20

let _ = x := 5

let a = 10

let b = a

let a = 5

let x = ref 1

let y = ref 2

let z = x

let w = y

let my_list = [ w; x; y; z ]

let my_list2 =
  List.map
    (fun x ->
      x := !x + 1;
      x)
    my_list


let sort_pair1 (pr : (int * int) ref) =
  if fst !pr < snd !pr then
    pr
  else
    ref (snd !pr, fst !pr)


let sort_pair2 (pr : (int * int) ref) =
  if fst !pr < snd !pr then
    ref (fst !pr, snd !pr)
  else
    ref (snd !pr, fst !pr)


let my_pair = ref (1, 2)

let sorted1 = sort_pair1 my_pair

let sorted2 = sort_pair2 my_pair

let _ = sorted1 := (5, snd !sorted1)

let _ = sorted2 := (fst !sorted2, 10)
