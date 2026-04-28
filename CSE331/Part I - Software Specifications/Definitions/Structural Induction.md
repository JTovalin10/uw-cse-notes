# Structural Induction

**Structural induction** is a proof technique used to reason about inductive data types, like Lists, of arbitrary length.

When using proof by calculation on lists, fixed-length lists are straightforward, but proving a fact about *any* length list $L$ requires structural induction.

To prove a claim $P(S)$ holds for *any* list $S$, we must prove two implications:

## 1. Base Case
Prove $P(nil)$.
- We can use any known facts and definitions.

## 2. Inductive Step
Prove $P(x :: L)$ for arbitrary variables $x$ and $L$.
- We can use any known facts and definitions.
- **Inductive Hypothesis:** We get to assume the claim holds for the sub-list $L$ (i.e., assume $P(L)$ is true). We can use this assumption in the calculation block.

## Why This Works
We build up the object using constructors (e.g., $nil$ then $2 :: nil$ then $1 :: 2 :: nil$). 
Structural induction builds up the proof the same way:
- $P(nil)$ is proven by the base case.
- $P(2 :: nil)$ is proven by the inductive step, assuming $P(nil)$.
- $P(1 :: 2 :: nil)$ is proven by the inductive step, assuming $P(2 :: nil)$.
This chain covers all possible lists of any size.

## General Case
For any inductive type, assume $P$ holds for any constructor *arguments* that are of the inductive type.
For example, if `type T := A | B(x: Z) | C(y: Z, t: T) | D(z: Z, u: T, v: T)`:
To prove $P(t)$ for any $t : T$, we prove:
- $P(A)$
- $P(B(x))$ for any $x : \mathbb{Z}$
- $P(C(y, t))$ for any $y : \mathbb{Z}$ and $t : T$, **assuming** $P(t)$ is true.
- $P(D(z, u, v))$ for any $z : \mathbb{Z}$ and $u, v : T$, **assuming** $P(u)$ and $P(v)$ are true.
