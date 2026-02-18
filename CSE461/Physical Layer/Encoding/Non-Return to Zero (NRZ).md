# Non-Return to Zero (NRZ)
- let a high voltage (+V) represent a 1, and low voltage (-V) represent a 0
- simplest encoding scheme

## Textbook Notes
The issue with encoding is long strings of 1s or 0s:

- **Baseline wander** — the receiver keeps a running average of the signal to distinguish high from low. Too many consecutive 1s or 0s skews this average, making it harder to detect transitions.
- **Clock recovery** — sender and receiver clocks must be precisely in sync. A solution is to derive the clock from the signal itself (clock recovery), but this requires frequent transitions. Long runs without transitions cause clock drift.

# Solutions
- [[NRZ Inverted (NRZI)]]
- [[Manchester Encoding]]

# Related
- [[Encoding]]
- [[Return to Zero (RZ)]]
- [[Simple Rate Model]]
