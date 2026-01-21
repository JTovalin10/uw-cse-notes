# What is Shannon Capacity?
The **theoretical maximum** rate at which data can be transmitted over a **noisy** channel without errors.

# Signal-to-Noise Ratio (SNR)
- How many levels we can distinguish depends on S/N ratio
- SNR = Signal Power / Noise Power
- Given on a log-scale in decibels (dB):
$$SNR_{dB} = 10 \log_{10}(S/N)$$

| SNR (dB) | S/N Ratio | Quality |
|----------|-----------|---------|
| 0 dB | 1:1 | Very noisy |
| 10 dB | 10:1 | Poor |
| 20 dB | 100:1 | Decent |
| 30 dB | 1000:1 | Good |

![[Pasted image 20260114224155.png]]

# Shannon-Hartley Theorem
$$C = B \log_2(1 + S/N) \text{ bits/sec}$$

Where:
- C = channel capacity (bits/sec)
- B = bandwidth (Hz)
- S/N = signal-to-noise ratio (linear, not dB)

# Nyquist vs Shannon
| | Nyquist | Shannon |
|--|---------|---------|
| Considers noise? | No | Yes |
| Formula | $2B \log_2 V$ | $B \log_2(1 + S/N)$ |
| Use case | Ideal channel | Real channel |

# Key Takeaways
- There exists a rate at which we can transmit data **without loss** over a noisy channel
- Doubling bandwidth → doubles capacity (linear)
- Doubling signal power → less than double capacity (diminishing returns, logarithmic)
- This is why we prefer more bandwidth over more power

# Related
- [[Nyquist Limit]]
- [[Rate]]
- [[Signal]]