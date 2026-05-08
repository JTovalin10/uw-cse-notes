(* From last class: *)
type expr =
  | Int of int
  | Add of expr * expr
  | Sub of expr * expr
  | Mul of expr * expr
  | Neg of expr

let rec interpret (ast : expr) : int =
  match ast with
  | Int i -> i
  | Add (l, r) -> interpret l + interpret r
  | Sub (l, r) -> interpret l - interpret r
  | Mul (l, r) -> interpret l * interpret r
  | Neg e -> -1 * interpret e


type pst =
  | Atom of string
  | Node of pst list

let rec ast_of_pst (pst : pst) : expr =
  match pst with
  | Atom s -> Int (int_of_string s)
  | Node [ Atom "+"; p1; p2 ] -> Add (ast_of_pst p1, ast_of_pst p2)
  | Node [ Atom "-"; p1; p2 ] -> Sub (ast_of_pst p1, ast_of_pst p2)
  | Node [ Atom "*"; p1; p2 ] -> Mul (ast_of_pst p1, ast_of_pst p2)
  | Node [ Atom "~"; p ] -> Neg (ast_of_pst p)
  | _ -> failwith "syntax error"


(* Arithmetic library only for positive integers *)
module type POSITIVE = sig
  val of_int : int -> int option

  val add : int -> int -> int

  val sub : int -> int -> int option
end

module Positive : POSITIVE = struct
  let of_int x =
    if x > 0 then
      Some x
    else
      None


  let add a b = a + b

  let mul a b = a * b

  let sub a b = of_int (a - b)
end

module type POS2 = sig
  type t

  val of_int : int -> t option

  val add : t -> t -> t

  val sub : t -> t -> t option

  val to_int : t -> int
end

module Pos2 : POS2 = struct
  type t = int

  let of_int x =
    if x > 0 then
      Some x
    else
      None


  let add a b = a + b

  let mul a b = a * b

  let sub a b = of_int (a - b)

  let to_int x = x
end

module type NONEMPTYLIST = sig
  type 'a t

  val single : 'a -> 'a t

  val cons : 'a -> 'a t -> 'a t

  val tl : 'a t -> 'a t (* can fail *)

  val hd : 'a t -> 'a (* never fail *)

  val len : 'a t -> int

  val map : ('a -> 'b) -> 'a t -> 'b t
end

module NelA : NONEMPTYLIST = struct
  type 'a t = 'a * 'a list

  let single x = (x, [])

  let cons x (x2, xs) = (x, x2 :: xs)

  let tl (x, xs) =
    match xs with
    | [] -> failwith "no non-empty tail"
    | y :: ys -> (y, ys)


  let hd (x, xs) = x

  let len (x, xs) = 1 + List.length xs

  let map f (x, xs) = (f x, List.map f xs)
end

module NelB : NONEMPTYLIST = struct
  type 'a t = 'a list

  let single x = [ x ]

  let cons x xs = x :: xs

  let tl xs =
    match xs with
    | [ x ] -> failwith "no non-empty tail"
    | x :: x2 :: xs -> x2 :: xs
    | [] -> failwith "not possible"


  let hd xs =
    match xs with
    | [] -> failwith "not possible"
    | x :: xs -> x


  let len = List.length

  let map = List.map
end

module NelC : NONEMPTYLIST = struct
  type 'a t =
    | Single of 'a
    | Cons of 'a * 'a t

  let single x = Single x

  let cons x xs = Cons (x, xs)

  let tl xs =
    match xs with
    | Single _ -> failwith "no non-empty tail"
    | Cons (_, xs) -> xs


  let hd xs =
    match xs with
    | Single x -> x
    | Cons (x, _) -> x


  let rec len xs =
    match xs with
    | Single _ -> 1
    | Cons (_, tl) -> 1 + len tl


  let rec map f xs =
    match xs with
    | Single x -> Single (f x)
    | Cons (x, xs) -> Cons (f x, map f xs)
end
