(*
f : T1 -> T2
x : T1 

T1 = (T3 * T4) (otherwise let (y, z) = x wouldn't type check)
y : T3
z : T4
T3 = int    (because (abs y))
T4 = int    (because `+ z`)
T2 = int    (because f returns an addition)

f : int * int -> int
*)

let f x =
  let y, z = x in
  abs y + z


(*
sum : T1 -> T2
xs : T1
T1 = T3 list
0 : int
T2 = int

x : int
xs' : T1 = T3 list 
T3 = int 

sum : int list -> int
*)
let rec sum xs =
  match xs with
  | [] -> 0
  | x :: xs' -> x + sum xs'


(*
broken_sum : T1 -> T2
xs : T1
T1 = T3 list
T2 = int
x : T3
xs' : T3 list
T3 = int
T3 = T1
*)
let rec broken_sum xs =
  match xs with
  | [] -> 0
  | x :: xs' -> x + broken_sum x


(*
length : T1 -> T2
xs : T1
T1 = T3 list
T2 = int
x : T3
xs' : T3 list
1 : int
xs' : T1

length : 'a list -> int
*)
let rec length xs =
  match xs with
  | [] -> 0
  | x :: xs' -> 1 + length xs'


(*
f : T1 * T2 * T3 -> T4
x : T1
T1 = int
y : T2
z : T3
(x, y, z) = (y, x, z) = T4
T1 * T2 * T3 = T4
T2 * T1 * T3 = T4
T1 = T2

f : T1 * T1 * T3 -> T1 * T1 * T3
f : 'a * 'a * 'b -> 'a * 'a * 'b
*)

let f ((x : 'a), y, z) =
  if true then
    (x, y, z)
  else
    (y, x, z)


let compose f g x = f (g x)
