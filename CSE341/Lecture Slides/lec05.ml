(* Records *)
type car =
  { make : string
  ; model : string
  ; year : int
  }

let my_first_car = { make = "Honda"; model = "Civic"; year = 2006 }

let my_current_car =
  { year = 2015; make = "Subaru"; model = "Forester" }


(* Syntax *)
(* Type check
   type r : {f1 : t1; ... ; fN : tN}

   e = { f1 = e1; ....; fN = eN }
*)

(* Evaluate
   e = { f1 = e1; ....; fN = eN }

   evaluates to {f1 = v1; ...; fN = vN }
*)

let is_older ((c1 : car), (c2 : car)) : bool = c1.year < c2.year

type date = int * int * int
(* programmer has to remember that it is day then month then year *)

type date =
  { day : int
  ; month : int
  ; year : int
  }

let date = { day = 1; month = 2; year = 2025 }

let date2 = { month = 2; day = 1; year = 2025 }

let day = "123"

(* Variants *)
type color =
  | Red
  | Green
  | Blue
  | Pink

let my_color = Red

let string_of_color (c : color) : string =
  match c with
  | Blue -> "blue"
  | Red -> "red"
  | Green -> "green"
  | Pink -> "pink"


type font =
  { color : color
  ; size : int
  }

let my_font = { color = Red; size = 12 }

type shape =
  | Circle of float
  | Rectangle of float * float
  | Square of float
  | Point of float * float

let my_shape1 = Circle (5.5 *. 2.4)

let my_shape2 = Rectangle (4.0, 25.1)

let area (s : shape) : float =
  match s with
  | Circle r -> 3.14 *. r *. r
  | Rectangle (l, w) -> l *. w
  | Square s -> s *. s
  | Point _ -> 0.


type rank =
  | Ace
  | King
  | Queen
  | Jack
  | Num of int

type suit =
  | Clubs
  | Spades
  | Diamonds
  | Hearts

type card =
  { rank : rank
  ; suit : suit
  }

let is_face_card (c : card) =
  match c.rank with
  | King
  | Queen
  | Jack ->
      true
  | Ace
  | Num _ ->
      false


let rec is_valid_card (c : card) =
  match c.rank with
  | Num n -> n >= 2 && n <= 10
  | _ -> true


let is_flush (cards : card list) =
  (* returns true if all of the cards in the list are suit s *)
  let rec all_suit (cards, s) =
    match cards with
    | [] -> true
    | hd :: tl -> hd.suit = s && all_suit (tl, s)
  in
  match cards with
  | [] -> true
  (* this is how you match on a list containing a first element and the rest of the list *)
  | hd :: tl -> all_suit (tl, hd.suit)


(* Variant type declaration *)
type expr =
  | Const of int
  | Negate of expr
  | Add of expr * expr

let expr1 = Const (-10)

let expr2 = Const 105

let expr3 = Negate (Const 3)

let expr4 = Add (Const 1, Negate (Add (Const 2, Const 3)))

let rec eval (e : expr) : int =
  match e with
  | Const i -> i
  | Negate e -> -1 * eval e
  | Add (e1, e2) -> eval e1 + eval e2
