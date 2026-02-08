Bit errors occur for many reasons, such as electrical interference or thermal noise. While rare, we still need mechanisms to check for and handle errors.

## Problems
1. Detecting errors
2. Correcting errors
	1. Often significantly harder than detection

## Error Detection Codes
The basic idea is to add redundant information to a frame that can be used to determine if any errors have been introduced. The goal is to provide a high probability of detecting errors combined with a relatively low number of redundant bits.

#### Internet Checksum Algorithm
NOTE: not used at the link level

*Idea*:
- **Sender**: add up all the words that are transmitted and then transmit the result of that sum
- **Receiver**: perform the same summation and compare—if the results don't match, the data was corrupted

Algorithm:
```c
u_short cksum(u_short* buf, int count) {
	register u_long sum = 0;
	while (count--) {
		sum += *buf++;
		if (sum & 0xFFFF0000) {
			sum &= 0xFFFF;
			sum++;
		}
	}
	return ~(sum & 0xFFFF);
}
```
This does well in terms of redundant bits (only 16) but does not do well in error detection—if a pair of single-bit errors occurs where one increments and the other decrements a word by the same amount, the errors will go undetected.

### Cyclic Redundancy Check
We can think of an $n+1$ bit message as being represented by an $n$ degree polynomial ($x^n$).
```
1010 = x^3 + 0 * x^2 + x^1 + 0 * x^0
```
We can think of the sender and receiver as exchanging polynomials.

The sender and receiver must agree on a divisor polynomial called $C(x)$, which is a polynomial of degree $k$ (where $k$ is the highest power with a nonzero coefficient).

We send $n + 1 + k$ bits to the receiver. The message is defined as $P(x)$. If we can divide $P(x)$ by $C(x)$ and it leaves a remainder of zero, then no error has occurred.

#### Key Properties (Modulo-2 Arithmetic)
- Any polynomial $B(x)$ can be divided by a divisor polynomial $C(x)$ if $B(x)$ is of higher degree than $C(x)$
- Any polynomial $B(x)$ can be divided once by a divisor polynomial $C(x)$ if $B(x)$ is of the same degree as $C(x)$
- The remainder obtained when $B(x)$ is divided by $C(x)$ is found by performing the XOR operation on each pair of matching coefficients

#### Long Division
1. Multiply $M(x)$ by $x^k$; that is, add $k$ zeros at the end of the message to create the zero-extended message $T(x)$
2. Divide $T(x)$ by $C(x)$ and find the remainder
3. Subtract the remainder from $T(x)$
![[Pasted image 20260207010035.png]]

#### Detection
CRC can detect:
- All single-bit errors, as long as the $x^k$ and $x^0$ terms have nonzero coefficients
- All double-bit errors, as long as $C(x)$ has a factor with at least three terms
- Any odd number of errors, as long as $C(x)$ contains the factor $(x+1)$
- Any burst errors for which the length of the burst is less than $k$ bits

#### Detection vs. Correction Trade-off
Detection-only schemes use more bandwidth for retransmissions and can introduce latency. However, correction requires a greater number of redundant bits—to send an error-correction code that is as strong as a detection-only code, you need significantly more overhead. As such, error correction tends to be most useful when:
1. Errors are quite probable (e.g., wireless links)
2. The cost of retransmission is too high