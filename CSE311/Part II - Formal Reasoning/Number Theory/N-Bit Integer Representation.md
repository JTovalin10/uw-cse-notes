# CSE 311: N-Bit Integer Representation

## Signed Integer (Two's Complement)

#Definition A **signed** $n$-bit integer uses **two's complement** representation and covers the range:
$$-2^{n-1} \leq x \leq 2^{n-1} - 1$$

**Key Property**: Two's complement representation of any number $y$ is equivalent to $y \bmod 2^n$. Therefore, arithmetic operations work modulo $2^n$:
$$y + 2^n \equiv_{2^n} y$$

## Unsigned Integer

#Definition An **unsigned** $n$-bit integer has no sign bit and covers the range:
$$0 \leq x \leq 2^n - 1$$

## Calculating a Positive Number in Binary

To convert a positive integer to binary, express it as a sum of powers of $2$.

Example:
$$99 = 64 + 32 + 2 + 1 = 2^6 + 2^5 + 2^1 + 2^0 \quad \Rightarrow \quad \texttt{01100011}$$
(The leading $0$ indicates the number is non-negative in signed representation.)

## Calculating a Negative Number in Binary (Two's Complement)

To find the binary representation of a negative number, first convert its positive counterpart, then apply the **flip-and-add-one** rule.

Example: To represent $-18$:
$$18 = 16 + 2 = 2^4 + 2^1 \quad \Rightarrow \quad \texttt{10010}$$

Flip all bits, then add 1:
$$\texttt{10010} \quad \Rightarrow \quad \texttt{01101} + 1 \quad \Rightarrow \quad \texttt{01110}$$

## Related

[[Modulo]] · [[Divides]] · [[Boolean Algebra]]
