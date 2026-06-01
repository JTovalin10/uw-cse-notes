(*
Syntax:
hw
pi
echo e
square e
*)

let interpret (s : string) : unit =
  match s with
  | "hw" -> print_endline "hello world"
  | "pi" -> print_endline "3.14159"
  | s when String.starts_with ~prefix:"echo" s ->
      let v = List.nth (String.split_on_char ' ' s) 1 in
      print_endline v
  | s when String.starts_with ~prefix:"square" s ->
      let v = List.nth (String.split_on_char ' ' s) 1 in
      let sqr = int_of_string v * int_of_string v in
      print_endline (string_of_int sqr)
  | _ -> failwith "syntax error"


(*
What's missing?

*)

(* Trefoil v0.5
   Syntax:
   e1 e2 -> e1 + e2 (assuming e1 and e2 are ints)
*)
let interpret (s : string) : int =
  match String.split_on_char ' ' s with
  | [ x; y ] -> (
      (* x is gonna be the first string and y is the second string *)
      try int_of_string x + int_of_string y with
      | Failure _ -> failwith "syntax error: not an int")
  | _ -> failwith "syntax error: not a string with two words"

(*
Syntax:
Trefoil v0.5
Why this syntax? e1 e2
Instead of this syntax? e1 + e2
Since language only has one operation, `+` isn't necessary!
If we wanted to add another operation (say subtraction) to Trefoil v0.5,
then we would need to add something to the syntax to distinguish between the two.

Language designers make choices about syntax
`f(1,2,3)`
`call f with (1,2,3)`

*)
