type expr =
  | Int of int
  | Add of expr * expr
  | Mul of expr * expr

let rec interpret (ast : expr) : int =
  match ast with
  | Int i -> i
  | Add (l, r) -> interpret l + interpret r
  | Mul (l, r) -> interpret l * interpret r
