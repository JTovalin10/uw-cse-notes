# CSE331: Loops

## Correctness of Loops

- Assignment and [[Conditionals|conditional]] reasoning is **mechanical**.
- Loop reasoning **cannot be made mechanical** — there is no way around this (this follows from **Rice's Theorem**).
- One extra bit of information fixes this:
  - The programmer must provide a **loop invariant**.
  - With the invariant, reasoning is again mechanical.

## Loop Invariants

A **loop invariant** is an assertion that is true every time at the **top of the loop**:

- It must be true when we get to the top the **first time**.
- It must **remain true** each time we execute the body `S` and loop back up.

Use `Inv:` to indicate a loop invariant in Floyd-style annotations.

```c
{{ P }}
{{ Inv: I }}
while (cond) {
    {{ I and cond }}
    S
    {{ I }}
}
{{ I and not cond }}
{{ Q }}
```

## Three Proof Obligations

To prove a loop correct, show:

1. **Initialization** — `I` holds initially (`P ⇒ I`).
2. **Preservation** — `S` preserves `I` (if `I and cond` holds before `S`, then `I` holds after).
3. **Postcondition** — `Q` holds when the loop exits (`I and not cond ⇒ Q`).

Often you also need **termination** (a separate argument using a decreasing variant).

## Picking an Invariant

Finding the right invariant is the hard part. A common technique is to **[[Visualizing Array Algorithms|visualize]]** the state of the array at each iteration — the picture often translates directly into the invariant.

## Related

- [[Floyd Logic]]
- [[Hoare Triples]]
- [[Conditionals]]
- [[Visualizing Array Algorithms]]
- [[Stronger Assertions]]
