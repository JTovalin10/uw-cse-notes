module StrMap = Map.Make (String)

(* AST *)
type value =
  | Int of int
  | Bool of bool
  | Symbol of string
  | Closure of
      string * expr * env (* arg name, fn body, defining env*)

and expr =
  | Val of value
  | Add of expr * expr
  | Sub of expr * expr
  | Mul of expr * expr
  | Eq of expr * expr
  | Neg of expr
  | And of expr * expr
  | Var of string
  | Let of string * expr * expr
  | If of expr * expr * expr
  | FnCall of expr * expr (* fn expr, arg expr *)
  | Lambda of string * expr (* arg name, body *)

(* env is a map with string keys and value values *)
and env = value StrMap.t

let string_of_value v =
  match v with
  | Int i -> string_of_int i
  | Bool b -> string_of_bool b
  | Symbol s -> s
  | Closure _ -> "<closure>"


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
  | Sub (l, r) ->
      Int (expect_int (interpret env l) - expect_int (interpret env r))
  | Mul (l, r) ->
      Int (expect_int (interpret env l) * expect_int (interpret env r))
  | Eq (l, r) ->
      Bool
        (expect_int (interpret env l) = expect_int (interpret env r))
  | Neg e -> Int (expect_int (interpret env e) * -1)
  | And (l, r) -> (
      match interpret env l with
      | Bool false -> Bool false
      | _ -> interpret env r)
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
  | FnCall (f, arg_expr) -> (
      match f with
      | Var f_name -> (
          match lookup f_name env with
          | None -> failwith "unbound fn"
          | Some (Closure (arg_name, body, defining_env)) ->
              let arg_value = interpret env arg_expr in
              let extended_env =
                bind f_name
                  (Closure (arg_name, body, defining_env))
                  (bind arg_name arg_value defining_env)
              in
              interpret extended_env body
          | Some _ -> failwith "not a function")
      | _ -> failwith "todo")
  | Lambda (arg_name, body) -> Closure (arg_name, body, env)


type binding =
  | ExprBinding of expr
  | VarBinding of string * expr
  | FnBinding of
      string * string * expr (* name of fn, name of arg, body *)

let rec interpret_binding env binding : env =
  match binding with
  | ExprBinding e ->
      let v = interpret env e in
      print_endline (string_of_value v);
      env
  | VarBinding (s, e) ->
      let v = interpret env e in
      bind s v env
  | FnBinding (f_name, arg_name, body) ->
      if f_name = arg_name then
        failwith "don't do this"
      else
        bind f_name (Closure (arg_name, body, env)) env


let rec interpret_bindings env bindings =
  match bindings with
  | [] -> env
  | b :: bs ->
      let new_env = interpret_binding env b in
      interpret_bindings new_env bs


let interpret_bindings = List.fold_left interpret_binding
