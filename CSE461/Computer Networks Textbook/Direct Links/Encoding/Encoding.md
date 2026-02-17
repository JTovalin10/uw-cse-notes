## Intro
We need to encode binary data into signals so the source node can send over a link and the receiving node can decode it back. This is done with [[Network Adaptor]]s.

# Problem
The issue with encoding is long strings of 1s or 0s (non-return to zero / NRZ):

- **Baseline wander** — the receiver keeps a running average of the signal to distinguish high from low. Too many consecutive 1s or 0s skews this average, making it harder to detect transitions.
- **Clock recovery** — sender and receiver clocks must be precisely in sync. A solution is to derive the clock from the signal itself (clock recovery), but this requires frequent transitions. Long runs without transitions cause clock drift.

# Solutions
- **NRZ Inverted (NRZI)** — the sender makes a transition to encode a 1 and stays at the current level to encode a 0. Solves consecutive 1s but **not** consecutive 0s.
- **Manchester Encoding** — merges clock with signal by transmitting the XOR of the NRZ-encoded data and the clock. Guarantees a transition every bit period, but **doubles** the signal rate, giving the receiver half the time to detect each pulse ([[CSE461/Computer Networks Textbook/Direct Links/Encoding/baud rate]]).

![[Pasted image 20260206235719.png]]
