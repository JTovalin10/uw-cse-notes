module StrMap = Map.Make (String)

(* AST *)
type value =
  | Nil
  | Int of int
  | Bool of bool
  | Symbol of string
  | Ref of value ref (* using OCaml ref *)

and expr =
  | Val of value
  | Add of expr * expr
  | Var of string
  | Let of string * expr * expr
  | If of expr * expr * expr
  | AllocRef of expr
  | ReadRef of expr
  | WriteRef of expr * expr

(* env is a map with string keys and value values *)
and env = value StrMap.t

let rec string_of_value v =
  match v with
  | Nil -> "nil"
  | Int i -> string_of_int i
  | Bool b -> string_of_bool b
  | Symbol s -> s
  | Ref v -> "ref: " ^ string_of_value !v


let empty = StrMap.empty

let bind = StrMap.add

let rec bind_all bindings env =
  match bindings with
  | [] -> env
  | (x, v) :: tl -> bind_all tl (bind x v env)


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
  | Var x -> (
      match lookup x env with
      | None -> failwith "unbound var"
      | Some v -> v)
  | Let (x, e1, e2) ->
      let v1 = interpret env e1 in
      let extended_env = bind x v1 env in
      interpret extended_env e2
  | If (predicate, then_branch, else_branch) -> (
      match interpret env predicate with
      | Bool false -> interpret env else_branch
      | _ -> interpret env then_branch)
  | AllocRef e ->
      let v = interpret env e in
      Ref (ref v)
  | ReadRef e -> (
      match interpret env e with
      | Ref v -> !v
      | _ -> failwith "not a ref")
  | WriteRef (e1, e2) -> (
      let new_v = interpret env e2 in
      match interpret env e1 with
      | Ref r ->
          r := new_v;
          Nil
      | _ -> failwith "not a ref")


type binding =
  | ExprBinding of expr
  | VarBinding of string * expr

let rec interpret_binding env binding : env =
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
