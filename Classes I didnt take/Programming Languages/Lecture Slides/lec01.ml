(* Intro to Ocaml *)

(* An OCaml program is a sequence of bindings. *)

(* Variable Binding *)
let x = 2
(*
Static Environment: { x : int }
Dynamic Environment: {x : 2 }
*)

(* A binding maps a name to a value
Syntax: `let` name = expression
*)

(*
When I say `x` in my program, that should evaluate to `2`
*)

let y = x + 10 (* In Python, this might be "2abc" (of type string) *)
(* Static Environment: { y: int; x : int} *)
(* Dynamic Environment: { y: 12; x: 2 } *)

let w = y * 2 (* 24 *)

let y = 5
(*
Static  : { y: int; y: int; x: int }
Dynamic : { y: 5; y: 12; x: 2 }
*)

let a = y + 1

(*
Creates a binding from the name `y` to the value `12`
*)

(* OCaml Environments:
1. Static Environment: Type information
2. Dynamic Environment: Runtime values
*)

let z = 10

let myfloat = 1.5
let b = 1.5 *. 2.

let c = "abc"
let d = c ^ "def"

let e = if x > 0 then "abc" else "100"

let max ((a : int), (b : int)) : int =
  if a < b then b else a

let add1 (x : int) : int =
  x + 1

let rec pow ((base : int), (exp : int)) : int =
  if exp = 0 then 1 else base * pow (base, exp - 1)