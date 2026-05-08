module StrMap = Map.Make (String)
module IntMap = Map.Make (Int)

type address = int

(* AST *)
type value =
  | Nil
  | Int of int
  | Bool of bool
  | Symbol of string
  | Ref of address

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

and heap = value IntMap.t

let rec string_of_value v =
  match v with
  | Nil -> "nil"
  | Int i -> string_of_int i
  | Bool b -> string_of_bool b
  | Symbol s -> s
  | Ref v -> "ref: " ^ string_of_int v


let empty_env = StrMap.empty

let bind_in_env = StrMap.add

let lookup_in_env = StrMap.find_opt

let empty_heap = IntMap.empty

let bind_in_heap = IntMap.add

let lookup_in_heap = IntMap.find

(* Need to make new heap addresses.
   IntMap.max_binding_opt
     - returns None if the map is empty
     - returns Some (k, v) where k is the largest k in the map, and v is the associated value
   We can return 1 + k to give a new address that has not been used yet
   (In a real heap implementation, you would want a way to free up slots and
   reuse freed slots, but we won't worry about that here. )
*)
let fresh_addr h =
  match IntMap.max_binding_opt h with
  | None -> 0
  | Some (k, _) -> k + 1


let rec interpret (env : env) (h : heap) (ast : expr) : value * heap =
  let expect_int v =
    match v with
    | Int i -> i
    | _ -> failwith "not an integer"
  in
  match ast with
  | Val v -> (v, h)
  | Add (l, r) ->
      let l_val, h = interpret env h l in
      let r_val, h = interpret env h r in
      (Int (expect_int l_val + expect_int r_val), h)
  | Var x -> (
      match lookup_in_env x env with
      | None -> failwith "unbound var"
      | Some v -> (v, h))
  | Let (x, e1, e2) ->
      let v1, h1 = interpret env h e1 in
      let extended_env = bind_in_env x v1 env in
      interpret extended_env h1 e2
  | If (predicate, then_branch, else_branch) -> (
      match interpret env h predicate with
      | Bool false, h -> interpret env h else_branch
      | _, h -> interpret env h then_branch)
  | AllocRef e ->
      let v, h = interpret env h e in
      let addr = fresh_addr h in
      (Ref addr, bind_in_heap addr v h)
  | ReadRef e -> (
      match interpret env h e with
      | Ref addr, h -> (lookup_in_heap addr h, h)
      | _ -> failwith "not a ref")
  | WriteRef (e1, e2) -> (
      match interpret env h e1 with
      | Ref addr, h ->
          let new_val, h = interpret env h e2 in
          (* not actually using the new heap... *)
          (Nil, bind_in_heap addr new_val h)
      | _ -> failwith "not a ref")
