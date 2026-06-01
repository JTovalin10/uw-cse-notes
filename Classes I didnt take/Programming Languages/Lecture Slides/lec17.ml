(* AST *)
type value =
  | Int of int
  | Bool of bool

let string_of_value v =
  match v with
  | Int i -> string_of_int i
  | Bool b -> string_of_bool b


type expr =
  | Val of value
  | Add of expr * expr
  | Sub of expr * expr
  | Mul of expr * expr
  | Neg of expr
  | Var of string
  | Let of string * expr * expr
  (* 1st is predicate, 2nd is then, 3rd is else *)
  | If of expr * expr * expr

(*
   (let ((x 2)) (let ((y  5)) (+ x y)))
*)

module StrMap = Map.Make (String)

(* env is a map with string keys and value values *)
type env = value StrMap.t

let empty = StrMap.empty

let bind = StrMap.add

let lookup = StrMap.find_opt

let rec interpret (env : env) (ast : expr) : value =
  let expect_int v =
    match v with
    | Int i -> i
    | _ -> failwith "not an integer"
  in
  match ast with
  | Val v -> v
  | Add (l, r) ->
      Int (expect_int (interpret env l) + expect_int (interpret env r))
  | Sub (l, r) ->
      Int (expect_int (interpret env l) - expect_int (interpret env r))
  | Mul (l, r) ->
      Int (expect_int (interpret env l) * expect_int (interpret env r))
  | Neg e -> Int (expect_int (interpret env e) * -1)
  | Var x -> (
      match lookup x env with
      | None -> failwith "unbound var"
      | Some i -> i)
  | Let (x, e1, e2) ->
      let v1 = interpret env e1 in
      let extended_env = bind x v1 env in
      interpret extended_env e2
  | If (predicate, then_branch, else_branch) -> (
      match interpret env predicate with
      | Bool false -> interpret env else_branch
      | _ -> interpret env then_branch)


type binding =
  | ExprBinding of expr
  | VarBinding of string * expr

let interpret_binding env binding : env =
  match binding with
  | ExprBinding e ->
      let v = interpret env e in
      print_endline (string_of_value v);
      env
  | VarBinding (s, e) ->
      let v = interpret env e in
      bind s v env


let rec interpret_bindings env bindings =
  match bindings with
  | [] -> env
  | b :: bs ->
      let new_env = interpret_binding env b in
      interpret_bindings new_env bs


let interpret_bindings = List.fold_left interpret_binding
