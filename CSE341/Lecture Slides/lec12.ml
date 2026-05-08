type 'a thunk = unit -> 'a

type 'a contents =
  | Unevaluated of 'a thunk
  | Evaluated of 'a

type 'a promise = 'a contents ref

(* delay : thunk -> promise *)
let delay (th : 'a thunk) : 'a promise = ref (Unevaluated th)

(* force : promise -> answer *)
let force (p : 'a promise) : 'a =
  match !p with
  | Unevaluated th ->
      let x = th () in
      p := Evaluated x;
      x
  | Evaluated a -> a


let rec fib n =
  if n <= 1 then
    n
  else
    fib (n - 1) + fib (n - 2)


let fib_p = delay (fun () -> fib 40)

type 'a stream = Stream of ('a * 'a stream) option thunk

let rec ones = Stream (fun () -> Some (1, ones))

let nats =
  let rec go start =
    Some (start, Stream (fun () -> go (start + 1)))
  in
  Stream (fun () -> go 0)


let rec take n (Stream t) =
  if n = 0 then
    []
  else
    match t () with
    | None -> failwith "empty stream"
    | Some (hd, rst) -> hd :: take (n - 1) rst


(* a stream that returns the square of every natural number *)
let squares =
  let rec go start =
    (start * start, Stream (fun () -> Some (go (start + 1))))
  in
  Stream (fun () -> Some (go 0))


(* Another way of writing squares that uses the nats stream *)
let squares_nats =
  let rec aux (Stream s) =
    match s () with
    | None -> Stream (fun () -> None)
    | Some (hd, rst) -> Stream (fun () -> Some (hd * hd, aux rst))
  in
  aux nats


let rec stream_map f (Stream s) =
  match s () with
  | None -> Stream (fun () -> None)
  | Some (hd, rst) -> Stream (fun () -> Some (f hd, stream_map f rst))


let squares2 = stream_map (fun x -> x * x) nats

let fib =
  let rec helper a b =
    Stream (fun () -> Some (a, helper b (a + b)))
  in
  helper 1 1


let rec add_streams (Stream s1) (Stream s2) =
  match (s1 (), s2 ()) with
  | Some (hd1, rst1), Some (hd2, rst2) ->
      Stream (fun () -> Some (hd1 + hd2, add_streams rst1 rst2))
  | _ -> Stream (fun () -> None)
