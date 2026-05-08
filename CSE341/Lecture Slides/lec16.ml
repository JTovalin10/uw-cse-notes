(* AST *)
type expr =
  | Int of int
  | Add of expr * expr
  | Sub of expr * expr
  | Mul of expr * expr
  | Neg of expr
  | Var of string
  (* string is the var name,
     the first expr is what it's bound to,
     and the second expr is the body *)
  | Let of string * expr * expr

(* type env = (string * int) list *)

module StrMap = Map.Make (String)

(* env is a map with string keys and integer values *)
type env = int StrMap.t

let empty = StrMap.empty

let bind = StrMap.add

let lookup = StrMap.find_opt

let rec interpret (env : env) (ast : expr) : int =
  match ast with
  | Int i -> i
  | Add (l, r) -> interpret env l + interpret env r
  | Sub (l, r) -> interpret env l - interpret env r
  | Mul (l, r) -> interpret env l * interpret env r
  | Neg e -> -1 * interpret env e
  | Var x -> (
      match lookup x env with
      | None -> failwith "unbound var"
      | Some i -> i)
  (*
     Incorrect option 1: Does not bind x to v to interpret e2
     |Let (x, e1, e2) -> let v = interpret env e1 in interpret env e2

     Incorrect option 2: Evaluates both e1 and e2 in the empty environment
     |Let (x, e1, e2) -> let v = interpret empty e1 in interpret empty e2

     Incorrect option 3: Evaluates e2 in the environment *only* containing x->v
     (drops other bindings in the current environment)
     |Let (x, e1, e2) ->
         let v = interpret env e1 in interpret (bind x v empty) e2 *)
  (* Correct implementation:
     evaluates e1 to v in the current environment
     then evaluates e2 in the current environment extended with a mapping from x -> v.
  *)
  | Let (x, e1, e2) ->
      let v1 = interpret env e1 in
      let extended_env = bind x v1 env in
      interpret extended_env e2


let e1 = Let ("x", Int 1, Add (Var "x", Int 4))

let e2 = Let ("x", Int 1, Let ("y", Int 2, Add (Var "x", Var "y")))

let e3 =
  Let
    ( "x"
    , Int 1
    , Add
        ( Let ("x", Int 2, Add (Var "x", Var "x"))
        , Mul (Var "x", Int 5) ) )


type pst =
  | Atom of string
  | Node of pst list

(*
string: x
PST: Atom "x"
AST: Var "x"


string: (+ x y)
PST: Node [Atom "+"; Atom "x"; Atom "y"]

AST: Add (Var "x", Var "y")

*)

let rec ast_of_pst (pst : pst) : expr =
  match pst with
  | Atom s -> (
      match int_of_string_opt s with
      | None -> Var s
      | Some i -> Int i)
  | Node [ Atom "+"; p1; p2 ] -> Add (ast_of_pst p1, ast_of_pst p2)
  | Node [ Atom "-"; p1; p2 ] -> Sub (ast_of_pst p1, ast_of_pst p2)
  | Node [ Atom "*"; p1; p2 ] -> Mul (ast_of_pst p1, ast_of_pst p2)
  | Node [ Atom "~"; p ] -> Neg (ast_of_pst p)
  | Node [ Atom "let"; Node [ Node [ Atom name; p1 ] ]; p2 ] ->
      Let (name, ast_of_pst p1, ast_of_pst p2)
  | _ -> failwith "syntax error"
