let incr x = x + 1
let dbl x = x * 2

let incr = fun x -> x + 1

(* let a = 4 *)

(* let f = if a > 5 then fun x -> x + 1 else fun x -> x + 2 *)

let rec map (f, xs) =
   match xs with
   | [] -> []
   | x :: xs' -> f x :: map (f, xs')

let a = 10
let b = 20
let add_a = fun x -> x + a

let a = 20

let c = add_a (5 * a)

let add_b = fun b -> a + b


(* Currying *)

let max (a, b) = if a < b then b else a

let max = fun a -> fun b -> if a < b then b else a

let add = fun x -> fun y -> x + y
let add x y = x + y 

let incr = add 1


type 'a tree =
| Leaf
| Node of 'a * 'a tree * 'a tree

(* ('a -> 'b) -> 'a list -> 'b list *)
let rec map f xs =
  match xs with
  | [] -> []
  | x :: xs' -> f x :: map f xs'


(* tree_map : ('a -> 'b) -> 'a tree -> 'b tree *)
let rec tree_map f tr =
   match tr with
   | Leaf -> Leaf
   | Node (x, l, r) -> Node (f x, tree_map f l, tree_map f r)
