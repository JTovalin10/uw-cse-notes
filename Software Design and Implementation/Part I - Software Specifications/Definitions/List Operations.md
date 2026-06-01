# List Operations

Mathematical definitions of common operations on lists:

## Concatenation ($+$)
Concatenating two lists puts all the elements of the first list before those of the second.
$$
\text{concat}(nil, R) := R
$$
$$
\text{concat}(x :: L, R) := x :: \text{concat}(L, R)
$$

## Reversal (rev)
Reversing a list uses concatenation as a helper function.
$$
\text{rev}(nil) := nil
$$
$$
\text{rev}(x :: L) := \text{rev}(L) + [x]
$$

## Last Element (last)
Retrieves the last element of a list.
$$
\text{last}(x :: nil) := x
$$
$$
\text{last}(x :: y :: L) := \text{last}(y :: L)
$$
Note that `last(nil)` is undefined. On a linked list, this operation takes $\Theta(n)$ time because it must walk down to the end of the list.
