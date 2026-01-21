# What is Shannon Capacity?
The **theoretical maximum** rate at which data can be transmitted over a **noisy** channel without errors.

# Signal-to-Noise Ratio (SNR)
[[ShannonCapacityComponents/Signal-to-Noise Ratio]]

# Shannon-Hartley Theorem
[[ShannonCapacityComponents/Shannon-Hartley Theorem]]

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
