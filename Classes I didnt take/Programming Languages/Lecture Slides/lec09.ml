(* Group Work 1 *)
let f xs = List.fold_left (+) 0 (List.filter (fun x -> x mod 2 = 0) xs)
let g xs = List.map String.length (List.filter (String.starts_with ~prefix:"a") xs)

let h xs = List.fold_left (fun acc x -> if acc > x then acc else x) 0 (List.map (fun x -> x * x) xs)

let add (a, b) = a + b


let add = fun x -> fun y -> x + y
let add a b = a + b

let curry =
  fun f ->
    fun a ->
      fun b ->
        f (a, b)

let tupled_add = fun (a, b) -> a + b
let curried_add = curry tupled_add

let uncurry =
  fun f ->
    fun (a, b) -> f a b


let compose f g = fun x -> f (g x)
let (%) = compose


let pipeline x f = f x
let (|>) = pipeline

let rec range n = if n < 0 then [] else n :: range (n - 1)
let dbl = List.map (fun x -> x * 2)
let sum = List.fold_left (+) 0 

let result = sum (dbl (range 10))

let result = 10
              |> range
              |> dbl
              |> sum 

(* Group Work 2 *)
let process_option f g =
  fun a ->
    match (f a) with
    | None -> None
    | Some b -> g b

let process_option f g a =
  match (f a) with
  | None -> None
  | Some b -> g b

let process_option = 
  fun f -> 
    fun g -> 
      fun a -> 
        match f a with
        | None -> None
        | Some b -> g b