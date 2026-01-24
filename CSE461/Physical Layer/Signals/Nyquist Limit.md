# Nyquist Theorem
For a **noiseless** channel with bandwidth B Hz:
- Maximum symbol rate = 2B symbols/sec (Nyquist rate)
- This is the theoretical limit for distinguishing symbols

![[Pasted image 20260114223927.png]]

# Nyquist Limit Formula
If there are V signal levels, the maximum bit rate is:
Multi-level
$$R = 2B \log_2 V \text{ bits/sec}$$
binary
$$R = 2B \text{bits/sec}$$
Where:
- B = bandwidth in Hz
- V = number of signal levels
- Each symbol carries $\log_2 V$ bits

# Examples
| Bandwidth | Levels (V) | Bits/symbol | Max Rate |
| --------- | ---------- | ----------- | -------- |
| 3 kHz     | 2          | 1           | 6 Kbps   |
| 3 kHz     | 4          | 2           | 12 Kbps  |
| 3 kHz     | 16         | 3           | 24 Kbps  |

# Key Insight
- More signal levels = more bits per symbol = higher rate
- But more levels are harder to distinguish (noise!)
- This is why [[Shannon Capacity]] (which includes noise) is the practical limit

# Related
- [[Signal]]
- [[Rate]]
- [[Modulation vs Coding]]
- [[Shannon Capacity]]
