# CSE331: Loop to Tail Recursion

Any ordinary loop can be translated into a **tail-recursive** function. A tail-recursive function is one where the recursive call is the very last operation performed in the method (i.e., no computation happens after the recursive call returns).

## Loop vs Recursion
- **Ordinary loops:** Save memory ($O(1)$ extra space) but are strictly less powerful than full recursion. They drop information about previous iterations, making them harder to mathematically model and sometimes harder to debug.
- **Tail Recursion:** Describes the exact same calculation as a loop. Functional languages (and some compilers) use **tail-call optimization** to execute tail recursion in $O(1)$ memory by reusing the stack frame.

## Translating a Loop to Tail Recursion
Every loop has:
1. State variables that change each iteration.
2. A condition to continue (or exit).
3. A body that updates the state.

We can map this to a recursive function with an **accumulator** variable:
- The **base case** corresponds to the loop termination condition.
- The **recursive case** corresponds to the loop body. The state variables are passed as arguments to the next recursive call.

### Example: Sum of an Array
**Loop Version:**
```java
int sum = 0;
int i = 0;
while (i < A.length) {
    sum = sum + A[i];
    i = i + 1;
}
return sum;
```

**Tail-Recursive Equivalent:**
```java
int sum_acc(int[] A, int i, int sum) {
    if (i == A.length) {
        return sum; // Base case (loop exit)
    } else {
        return sum_acc(A, i + 1, sum + A[i]); // Tail call (loop body)
    }
}
```

## Why Translate?
- **Analysis:** Loops mutate state, which math cannot describe well. Tail recursive functions don't mutate state; they just pass new values. This makes it easier to prove correctness.
- **Invariant:** The loop invariant in a while loop is mathematically equivalent to the definition of the tail-recursive helper function.

## Related
- [[Loops]]
- [[Floyd Logic]]