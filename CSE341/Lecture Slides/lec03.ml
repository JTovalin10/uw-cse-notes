let my_pair : int * int = (1,1)
let my_pair2 : int * bool = (1, true)
let my_pair3 : string * bool = ( "hello", false )
let my_pair4 = ((1, 1.5), false)

let add_5_to_second (pair : int * int) : (int * int) =
  
  ( fst pair , snd pair  + 5)


let my_nested_pair : (int * int) * int = ((1, 2), 5 + 10) 
let my_triple : int * int * int = (1, 2, 5 + 10)

let my_list = 0 :: [1;2;3]


let empty_int_list : int list = []


let my_int_list = [7; 8; 9]


let rec length (l : 'a list) : int =
  if l = [] then 0 else 1 + length (List.tl l)