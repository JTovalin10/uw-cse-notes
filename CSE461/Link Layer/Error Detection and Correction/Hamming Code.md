## Encode
Gives us a method for constructing a code with a distance of 3
- use $n = 2^k - k - 1$
- put check bits in positions $p$ that are powers of 2, starting with position 1
	- the remaining go in the leftover positions left to right
- check bits in position p are parity of positions with a p term in their values
- there is also an easy way to correct

The way we choose 0 and 1 for the parity bit is:
1. put the parity bits in powers of 2's
2. count the number of ones in the positions where the binary representation of the integer for (position & 1) != 0.
	1. if even then the parity bit is 0
	2. if odd then the parity bit is 1
![[Screenshot 2026-01-22 at 2.37.43 PM.png]]
# Decode
1. recompute check bits (with parity sum including the check bit)
2. arrange as a binary number
3. we take the xor of each hamming position (exclusive)
4. value (syndrome) tells error position
5. value of zero means no error
6. otherwise, flip bit to correct
![[Screenshot 2026-01-22 at 2.39.08 PM.png]]