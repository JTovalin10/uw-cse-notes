Gives us a method for constructing a code with a distance of 3
- use $n = 2^k - k - 1$
- put check bits in positions $p$ that are powers of 2, starting with position 1
- check bits in position p is parity of position with a p term in their values
- there is also a easy to to correct
![[Screenshot 2026-01-22 at 2.37.43 PM.png]]
# Decode
1. recompute check bits (with parity sum including the check bit)
2. arrange as a binary number
3. value (syndrome) tells error position
4. value of zero means no error
5. otherwise, flip bit to correct
![[Screenshot 2026-01-22 at 2.39.08 PM.png]]