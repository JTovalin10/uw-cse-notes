## Binary Exponential Backoff (BEB)
A collision resolution algorithm used in Ethernet ([[Carrier Sense Multiple Access (CSMA)|CSMA]]/CD). After a collision, each sender picks a random wait time from an exponentially growing range before retrying:

- After the 1st collision: wait a random time in [0, 1] slot times
- After the 2nd collision: wait a random time in [0, 3] slot times
- After the nth collision: wait a random time in [0, 2^n - 1] slot times

### Limits
- **Capped at $n=10$**: The range size stops growing after the 10th collision (max range $[0, 1023]$).
- **Maximum Attempts**: If a frame experiences **16 consecutive collisions**, it is discarded and the error is reported to the higher layer.

See also: [[Link Layer - Ethernet CSMA-CD]]
