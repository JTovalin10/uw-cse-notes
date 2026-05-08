(* -------- AST -------- *)
type expr =
  | Int of int
  | Add of expr * expr
  | Sub of expr * expr
  | Mul of expr * expr
  | Neg of expr

(* -------- Tokens -------- *)
type token =
  | INT of int
  | PLUS
  | MINUS
  | TIMES
  | LPAREN
  | RPAREN

(* -------- Lexer -------- *)
let tokenize (s : string) : token list =
  let len = String.length s in
  let rec skip i =
    if i < len && (s.[i] = ' ' || s.[i] = '\t' || s.[i] = '\n') then
      skip (i + 1)
    else
      i
  in
  let rec number i acc =
    if i < len && '0' <= s.[i] && s.[i] <= '9' then
      number (i + 1) ((acc * 10) + (Char.code s.[i] - Char.code '0'))
    else
      (acc, i)
  in
  let rec loop i acc =
    let i = skip i in
    if i >= len then
      List.rev acc
    else
      match s.[i] with
      | '+' -> loop (i + 1) (PLUS :: acc)
      | '-' -> loop (i + 1) (MINUS :: acc)
      | '*' -> loop (i + 1) (TIMES :: acc)
      | '(' -> loop (i + 1) (LPAREN :: acc)
      | ')' -> loop (i + 1) (RPAREN :: acc)
      | c when '0' <= c && c <= '9' ->
          let n, j = number i 0 in
          loop j (INT n :: acc)
      | c -> failwith ("unexpected character: " ^ String.make 1 c)
  in
  loop 0 []


(* -------- Parser core -------- *)

(*
expr    ::= term (("+" | "-") term)*
term    ::= factor ("*" factor)*
factor  ::= INT
          | "(" expr ")"
          | "-" factor

*)

exception ParseError

let expect_token t toks =
  match (t, toks) with
  | PLUS, PLUS :: rest -> rest
  | MINUS, MINUS :: rest -> rest
  | TIMES, TIMES :: rest -> rest
  | LPAREN, LPAREN :: rest -> rest
  | RPAREN, RPAREN :: rest -> rest
  | _ -> raise ParseError


let parse_int toks =
  match toks with
  | INT n :: rest -> (Int n, rest)
  | _ -> raise ParseError


(* -------- Grammar -------- *)
(* expr ::= term (("+"|"-") term)* *)
let rec parse_expr toks =
  let lhs, toks1 = parse_term toks in
  parse_expr_tail lhs toks1


and parse_expr_tail lhs toks =
  match toks with
  | PLUS :: rest ->
      let rhs, rest2 = parse_term rest in
      parse_expr_tail (Add (lhs, rhs)) rest2
  | MINUS :: rest ->
      let rhs, rest2 = parse_term rest in
      parse_expr_tail (Sub (lhs, rhs)) rest2
  | _ -> (lhs, toks)


(* term ::= factor ("*" factor)* *)
and parse_term toks =
  let lhs, toks1 = parse_factor toks in
  parse_term_tail lhs toks1


and parse_term_tail lhs toks =
  match toks with
  | TIMES :: rest ->
      let rhs, rest2 = parse_factor rest in
      parse_term_tail (Mul (lhs, rhs)) rest2
  | _ -> (lhs, toks)


(* factor ::= INT | "(" expr ")" | "-" factor *)
and parse_paren toks =
  let rest1 = expect_token LPAREN toks in
  let e, rest2 = parse_expr rest1 in
  let rest3 = expect_token RPAREN rest2 in
  (e, rest3)


and parse_neg toks =
  let rest1 = expect_token MINUS toks in
  let e, rest2 = parse_factor rest1 in
  (Neg e, rest2)


and parse_factor toks =
  match toks with
  | INT n :: rest -> (Int n, rest)
  | LPAREN :: rest ->
      let e, rest2 = parse_expr rest in
      let rest3 = expect_token RPAREN rest2 in
      (e, rest3)
  | MINUS :: rest ->
      let e, rest2 = parse_factor rest in
      (Neg e, rest2)
  | _ -> raise ParseError


let parse s =
  let tokens = tokenize s in
  let ast, rest = parse_expr tokens in
  match rest with
  | [] -> ast
  | _ -> raise ParseError
