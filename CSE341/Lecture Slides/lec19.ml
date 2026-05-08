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
  | Eq of expr * expr
  | Neg of expr
  | Var of string
  | Let of string * expr * expr
  | If of expr * expr * expr
  | FnCall of string * expr (* fn name, arg expr *)

module StrMap = Map.Make (String)

(* env is a map with string keys and value values *)
type env = env_entry StrMap.t

and env_entry =
  | VarEntry of value
  | FnEntry of
      string * expr * env (* arg name, fn body, defining env *)

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
  | Eq (l, r) ->
      Bool
        (expect_int (interpret env l) = expect_int (interpret env r))
  | Neg e -> Int (expect_int (interpret env e) * -1)
  | Var x -> (
      match lookup x env with
      | None -> failwith "unbound var"
      | Some (VarEntry i) -> i
      | Some (FnEntry _) ->
          failwith "it was a function not a variable")
  | Let (x, e1, e2) ->
      let v1 = interpret env e1 in
      let extended_env = bind x (VarEntry v1) env in
      interpret extended_env e2
  | If (predicate, then_branch, else_branch) -> (
      match interpret env predicate with
      | Bool false -> interpret env else_branch
      | _ -> interpret env then_branch)
  | FnCall (f_name, arg_expr) -> (
      match lookup f_name env with
      | None -> failwith "unbound fn"
      | Some (VarEntry _) -> failwith "not a function"
      | Some (FnEntry (arg_name, body, defining_env)) ->
          let arg_value = interpret env arg_expr in
          let extended_env =
            bind f_name
              (FnEntry (arg_name, body, defining_env))
              (bind arg_name (VarEntry arg_value) defining_env)
          in
          interpret extended_env body)


type binding =
  | ExprBinding of expr
  | VarBinding of string * expr
  | FnBinding of
      string * string * expr (* name of fn, name of arg, body *)

let interpret_binding env binding : env =
  match binding with
  | ExprBinding e ->
      let v = interpret env e in
      print_endline (string_of_value v);
      env
  | VarBinding (s, e) ->
      let v = interpret env e in
      bind s (VarEntry v) env
  | FnBinding (f_name, arg_name, body) ->
      if f_name = arg_name then
        failwith "don't do this"
      else
        bind f_name (FnEntry (arg_name, body, env)) env


let rec interpret_bindings env bindings =
  match bindings with
  | [] -> env
  | b :: bs ->
      let new_env = interpret_binding env b in
      interpret_bindings new_env bs


let interpret_bindings = List.fold_left interpret_binding

(*
(define (f x) (+ x 1))

(define (g n)
  (if (= n 0)
    0
    (+ n (g (- n 1)))))

(g 0)
(g 3)

*)

let f = FnBinding ("f", "x", Add (Var "x", Val (Int 1)))

let g =
  FnBinding
    ( "g"
    , "n"
    , If
        ( Eq (Var "n", Val (Int 0))
        , Val (Int 0)
        , Add (Var "n", FnCall ("g", Sub (Var "n", Val (Int 1)))) ) )


let call1 = FnCall ("g", Val (Int 0))

let call2 = FnCall ("g", Val (Int 3))

(*
(define my_pair (cons 1 2))
(car my_pair) => 1
(cdr my_pair) => 2

(define my_list (cons 1 (cons 2 (cons 3 nil))))       sort of equivalent to [1;2;3]
                                                      sort of equivalent to (1, (2, (3, nil)))


Proper list: ends in nil
(cons 1 (cons true nil))

Improper list: does not
(cons 1 true)

*)
