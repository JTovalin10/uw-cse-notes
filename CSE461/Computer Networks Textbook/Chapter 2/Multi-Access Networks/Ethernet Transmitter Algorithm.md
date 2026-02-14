When the adaptor has a frame to send:
1. **Line idle** — transmit immediately. The 1500-byte upper bound ensures no single adaptor can monopolize the link.
2. **Line busy** — wait for idle, then transmit immediately (after a mandatory 9.6 µs inter-frame gap). This makes Ethernet a **1-persistent** protocol (transmit with probability 1 when the line goes idle).

> A **p-persistent** protocol transmits with probability *p* and defers with probability *1 − p*. Lower *p* reduces the chance of simultaneous transmissions when multiple adaptors are waiting, but Ethernet's 1-persistent approach has proven effective in practice.

## Collision Handling

- When two or more frames collide, each sender transmits a **32-bit jamming sequence** then stops. The minimum transmission in a collision is therefore 96 bits (64-bit preamble + 32-bit jam), sometimes called a **runt frame**.
- The worst-case detection delay occurs when two hosts are at opposite ends of the network; this is why every Ethernet frame must be at least **512 bits (64 bytes)** and the maximum cable length is **2500 m**.

## Exponential Backoff

- After a collision the adaptor picks a random *k* in `[0, 2^n − 1]` and waits *k × 51.2 µs*, where *n* is the number of collisions so far at the current packet (so this resets with every packet that is sent)is i.
- *n* is capped (typically at 10), and the adaptor gives up after 16 failed attempts and reports a transmit error to the host.

![[Pasted image 20260208022712.png]]
