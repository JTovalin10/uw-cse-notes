clients get conectivity form a wired access point

its a multi access problem

multi antennas increase data rate by:
- each antenna increases data rate by x
- it has to solve a linear equation however each antenna should be different

# Physical layer
uses 20/49 MHz channels on ISM (unlicensed) bands
- 802/11b/g/n on 2.4 GHz
- 802.11 a/n on 5 GHz

OFDM Modulation (except legacy 802.11b)
- diff amplitudes/phases for varying SNRS
- rate from 6 to 64 Mbps plus error correction
- 802.11n uses multiple antennas

# Link Layer
Multiple access uses [[Carrier Sense Multiple Access (CSMA)]]; RTS/CA optional (only cares about avoiding collisions and [[Hidden Terminals]] problem)

frames are ACKed and retransmitted with [[Automatic Repeat reQuest (ARQ)]], as it wants to mitigate any noise conflict

funky addresses

errors are detected with a 32-bit CRC
![[Screenshot 2026-02-04 at 1.18.01 PM.png]]

with multiple access it uses [[Binary Exponential Backoff (BEB)]]