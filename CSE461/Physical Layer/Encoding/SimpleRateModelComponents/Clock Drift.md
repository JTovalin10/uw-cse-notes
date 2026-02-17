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

- a solution is to derive the clock from the signal itself (clock recovery), but this requires frequent transitions

# Related
- [[../Simple Rate Model|Simple Rate Model]]
- [[Clock Recovery 4B5B]]
- [[Baseline Wander]]
- [[Non-Return to Zero (NRZ)]]
