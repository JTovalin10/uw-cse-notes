module StrMap = Map.Make (String)

type typ =
  | TInt
  | TBool

(* AST *)
type value =
  | Int of int
  | Bool of bool

and expr =
  | Val of value
  | Add of expr * expr
  | Div of expr * expr
  | Var of string
  | Let of string * expr * expr
  | If of expr * expr * expr
  | And of expr * expr
  | Eq of expr * expr

(* env is a map with string keys and value values *)
and dyn_env = value StrMap.t

and static_env = typ StrMap.t

let rec type_check (env : static_env) (e : expr) : typ =
  let expect_type expected actual =
    if expected = actual then
      ()
    else
      failwith "type error!"
  in
  match e with
  | Val v -> (
      match v with
      | Int _ -> TInt
      | Bool _ -> TBool)
  | Add (l, r) ->
      expect_type TInt (type_check env l);
      expect_type TInt (type_check env r);
      TInt
  | Div (l, r) ->
      expect_type TInt (type_check env l);
      expect_type TInt (type_check env r);
      TInt
  | Var x -> (
      match StrMap.find_opt x env with
      | None -> failwith "unbound var"
      | Some t -> t)
  | Let (x, e1, e2) ->
      let t1 = type_check env e1 in
      let extended_env = StrMap.add x t1 env in
      type_check extended_env e2
  | If (p, t, e) ->
      expect_type TBool (type_check env p);
      let t1 = type_check env t in
      let t2 = type_check env e in
      if t1 = t2 then
        t1
      else
        failwith "branch types don't match"
  | And (e1, e2) ->
      ignore (type_check env e1);
      ignore (type_check env e2);
      TBool
  | Eq (e1, e2) ->
      ignore (type_check env e1);
      ignore (type_check env e2);
      TBool


let rec interpret (env : dyn_env) (e : expr) : value =
  match e with
  | Val v -> v
  | Add (l, r) -> (
      match (interpret env l, interpret env r) with
      | Int i, Int j -> Int (i + j)
      | _ -> failwith "not an int")
  | Div (l, r) -> (
      match (interpret env l, interpret env r) with
      | Int i, Int j ->
          if j = 0 then
            failwith "div by 0!"
          else
            Int (i / j)
      | _ -> failwith "not an int")
  | Var x -> (
      match StrMap.find_opt x env with
      | Some v -> v
      | None -> failwith "unbound var")
  | Let (x, e1, e2) ->
      let v1 = interpret env e1 in
      let extended_env = StrMap.add x v1 env in
      interpret extended_env e2
  | If (predicate, then_branch, else_branch) -> (
      match interpret env predicate with
      | Bool true -> interpret env then_branch
      | Bool false -> interpret env else_branch
      | _ -> failwith "if predicate wasn't a boolean")
  | And (l, r) -> (
      match interpret env l with
      | Bool false -> Bool false
      | _ -> (
          match interpret env r with
          | Bool false -> Bool false
          | _ -> Bool true))
  | Eq (l, r) -> (
      match (interpret env l, interpret env r) with
      | Int i, Int j -> Bool (i = j)
      | Bool i, Bool j -> Bool (i = j)
      | _ -> Bool false)
