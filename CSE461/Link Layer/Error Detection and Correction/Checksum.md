Idea: sum up data in N-bit words
	widely used in, e.g., [[Transmission Control Protocol (TCP)|TCP]]/[[Internet Protocol (IP)|IP]]/[[User Datagram Protocol (UDP)|UDP]]
![[Screenshot 2026-01-21 at 11.30.48 AM.png]]
stronger protection than [[Parity Bits]]

The [[Hamming Distance]] is 2 with an error detection of <= 1 and error correction of 0
# Internet
## What is it
sum is defined in 1s complement arithmetic (must add carries). Its the negative sum
## Sending
1. arrange data in 16-bit words
2. put zero in checksum position, add
3. add any carryover back to get 16 bits
4. negate (complement) to get sum
![[Screenshot 2026-01-22 at 2.29.17 PM.png]]
## Receiving
1. Arrange Data in 16-bit words
2. checksum will be non-zero, add
3. add any carryover back to get 16 bits
4. negate the result and check it is 0
![[Screenshot 2026-01-22 at 2.29.57 PM.png]]