# Non-Return to Zero (NRZ)
The simplest encoding: map 1 to high signal, 0 to low signal, and hold for the bit duration — the signal does **not** return to zero between bits.

# Problems
Long strings of 1s or 0s cause:
- [[Baseline Wander]]
- [[Clock Drift]]

# Solutions
- [[NRZI]]
- [[Manchester Encoding]]
- [[Clock Recovery 4B5B]]

# Related
- [[Simple Coding]]
- [[../Simple Rate Model|Simple Rate Model]]
