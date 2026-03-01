Clients get connectivity from a wired access point.

It's a multi-access problem.

**Multiple antennas** increase data rate via **[[Multiple Input Multiple Output (MIMO)|MIMO]]** — each antenna provides a spatial stream; the receiver solves a linear system to separate them. More antennas → more parallel streams → higher throughput.

# Physical layer
uses 20/40 MHz channels on **ISM bands** (Industrial, Scientific, Medical — unlicensed radio bands)
- 802/11b/g/n on 2.4 GHz
- 802.11 a/n on 5 GHz

[[Orthogonal Frequency-Division Multiple Access (OFDMA)|OFDM]] Modulation (except legacy 802.11b)
- diff amplitudes/phases for varying [[Signal-to-Noise Ratio (SNR)|SNRs]]
- rate from 6 to 64 Mbps plus error correction
- 802.11n uses multiple antennas ([[Multiple Input Multiple Output (MIMO)|MIMO]])

# Link Layer
Multiple access uses [[Carrier Sense Multiple Access (CSMA)]]; **RTS/CTS** (Request to Send / Clear to Send) optional (only cares about avoiding collisions and [[Hidden Terminals]] problem)

frames are ACKed and retransmitted with [[Automatic Repeat reQuest (ARQ)]], as it wants to mitigate any noise conflict

funky addresses

errors are detected with a 32-bit [[Cyclic Redundancy Check (CRC)|CRC]]
![[Screenshot 2026-02-04 at 1.18.01 PM.png]]

with multiple access it uses [[Binary Exponential Backoff (BEB)]]