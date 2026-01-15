- Rate 
	- in bits/second
- delay
	- in seconds, related to length
![[Pasted image 20260114215227.png]]

# Potential Fixes
## Simple Coding
- let a high voltage (+V) represent a 1, and low voltage (-V) represent a 0
- then go back to 0V for a "reset"
	- this is called RZ (return to zero)
![[Pasted image 20260114220330.png]]
## Clock Recovery - 4B/5B
Map every 4 data bits into 5 code bits without long runs of zeros
- has at most 3 zeros in a row
- also invert signal level on a 1 to break up long runs of 1s
![[Pasted image 20260114220504.png]]
# Clock Synchronization or Clock Drift
We assume that the receiver knows exactly when to look at the wire to read a bit, However, the sender and receiver have independent internal clocks (oscillators)
1. No transition 
	1. when you send ```101010```, the voltage on the wire changes frequently. The receiver uses these changes to re-align its clock with the sender
2. Long run (the issue)
	1. when you send ```10000...000```, the voltage on the wire stays constant (e.g., Low) for a very long time. There is no transition to help the receiver sync up
3. Clock Drift
	1. no two clocks are perfect. If the receiver clock is even 0.1% faster or slower than the sender's, and there are no transitions to correct it, the timing error accumulates
## Bit Slip
Eventually, the receiver will look at the wire at the wrong time
- sender
	- sends 100 zeros'
- receiver (running slightly faster)
	- might count 101 zeros
- receiver (running slightly slow)
	- might count 99 zeros
Because the signal line looks like one long, flat line of voltage, the receiver has no way to verify if it has counted the correct number of bits

# Baseline wander
while sync is the main timing issue, long strings of 0s or 1s also cause **baseline wandering** in electrical systems
- if a signal is "AC coupled" (common in Ethernet to avoid ground loops), it relies on an average voltage of zero
- sending a long string of 0s (which might be -5V) drags the average voltage down
- eventually, the receiver can no longer distinguish between a "0" and a "1" because the electrical baseline has shifted

# Related
- [[Rate]]
- [[Delay]]
- [[Modulation vs Coding]]
- [[Modulation]]
- [[Physical Layer]]
