(* AST *)
type value =
  | Int of int
  | Bool of bool
  | Symbol of string

let string_of_value v =
  match v with
  | Int i -> string_of_int i
  | Bool b -> string_of_bool b
  | Symbol s -> s


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
  | Cons of expr * expr
  | Car of expr
  | Cdr of expr

module StrMap = Map.Make (String)

(* env is a map with string keys and value values *)
type env = env_entry StrMap.t

and env_entry =
  | VarEntry of value
  | FnEntry of
      string * expr * env (* arg name, fn body, defining env *)

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
  | _ -> failwith "not implemented"


type binding =
  | ExprBinding of expr
  | VarBinding of string * expr
  | FnBinding of
      string * string * expr (* name of fn, name of arg, body *)
  | StructBinding of string * string (* name of struct, field name *)

let binding_of_string s = failwith "not implemented"

let rec interpret_binding env binding : env =
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
  | StructBinding (struct_name, field_name) ->
      (*
    (struct foo bar) should behave as if the user had typed:
      (define (foo x) (cons 'foo x))
      (define (foo? x) (= (car x) 'foo))
      (define (foo-bar x) (cdr x))

    *)
      let ctor =
        FnEntry ("x", Cons (Val (Symbol struct_name), Var "x"), env)
      in
      let pred =
        FnEntry
          ("x", Eq (Car (Var "x"), Val (Symbol struct_name)), env)
      in
      let proj = FnEntry ("x", Cdr (Var "x"), env) in
      bind_all
        [ (struct_name, ctor)
        ; (struct_name ^ "?", pred)
        ; (struct_name ^ "-" ^ field_name, proj)
        ]
        env


let rec interpret_bindings env bindings =
  match bindings with
  | [] -> env
  | b :: bs ->
      let new_env = interpret_binding env b in
      interpret_bindings new_env bs


let interpret_bindings = List.fold_left interpret_binding
