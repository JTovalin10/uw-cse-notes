Given n data bits, generate k check bits such that **n+k** bits are evenly divisible by a generator **C**
# How it works
its based on mathematics of finite fields, in which "numbers" represent polynomials
- 10011010 = $x^7 + x^4 + x^3 + x^1$
This means we work with binary values and operate using modulo 2 arithmetic

Properties
1. [[Hamming Distance]] = 4, detects u to triple bit errors
2. also odd number of errors
3. and bursts of up to **k** buts in error
4. not vilnerable to systematics errors like [[Checksum]]
## Sending
1. extend the n data bits with k zeros
2. divide by the generator value C
3. keep reminder, ignore quotient
4. Keep remainder, ignore quotient
5. adjust k check bits by remainder
## Receive
1. divide and check for zero remainder
![[Screenshot 2026-01-22 at 2.34.21 PM.png]]