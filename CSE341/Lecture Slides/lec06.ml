type int_option =
  | NoInt
  | OneInt of int

type 'a myoption =
  | MyNone
  | MySome of 'a

type int_list =
  | IntEmpty
  | IntCons of int * int_list

type 'a mylist =
  | MyEmpty
  | MyCons of 'a * 'a mylist

(* sum_int_list *)
let rec sum_int_list (l : int_list) =
  match l with
  | IntEmpty -> 0
  | IntCons (i, l') -> i + sum_int_list l'


(* sum_int_option_list *)
let rec sum_int_option_list (l : int_option mylist) =
  match l with
  | MyEmpty -> 0
  | MyCons (a, l') -> (
      match a with
      | NoInt -> sum_int_option_list l'
      | OneInt i -> i + sum_int_option_list l')


let rec sum_int_option_list2 (l : int_option mylist) =
  match l with
  | MyEmpty -> 0
  | MyCons (NoInt, l') -> sum_int_option_list2 l'
  | MyCons (OneInt i, l') -> i + sum_int_option_list2 l'


let rec f (l : (int option * int option) list) =
  match l with
  | [] -> 0
  | (Some x, None) :: xs -> 1
  | (None, None) :: xs -> 2
  | _ -> 3


let rec sum_up_to n =
  if n = 0 then
    0
  else
    n + sum_up_to (n - 1)


let sum_up_to2 n =
  let rec aux n acc =
    if n = 0 then
      acc
    else
      aux (n - 1) (n + acc)
  in
  aux n 0
