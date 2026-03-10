# Physical Layer: Signals and Channel Capacity

## Low-Level Primer: The Physics of Information
To transmit data, digital bits must be mapped to physical signals. A channel's ability to carry information is fundamentally limited by its **Bandwidth** (the range of frequencies it can pass) and the **Noise** level.

---

## 1. Frequency Domain Representation

Every complex signal can be viewed as a sum of simple sine waves at different frequencies (Fourier analysis).
*   **Signal Bandwidth**: The difference between the highest and lowest frequencies contained in the signal.
*   **Channel Bandwidth ($B$)**: The range of frequencies that the channel can transmit with minimal attenuation (measured in **Hz**).

[Image: Graph showing a signal in the time domain vs. its frequency spectrum]

---

## 2. Fundamental Capacity Limits

### Nyquist Limit (Noiseless Channels)
Defines the maximum bit rate for a channel with zero noise. The only constraint is the ability to distinguish between discrete signal levels.
$$\text{Max Bit Rate} = 2B \log_2 V \text{ (bps)}$$
*   **$B$**: Bandwidth in Hz.
*   **$V$**: Number of discrete signal levels (e.g., binary $V=2$).
*   **Key Insight**: You can increase the bit rate by adding more voltage levels, but they become harder to distinguish as they get closer together.

### Shannon-Hartley Theorem (Noisy Channels)
Defines the absolute theoretical maximum error-free bit rate for a real-world channel with noise.
$$\text{Capacity } (C) = B \log_2(1 + \frac{S}{N}) \text{ (bps)}$$
*   **$S/N$**: **Signal-to-Noise Ratio (SNR)**.
*   **Key Insight**: 
    1.  Capacity increases **linearly** with Bandwidth ($B$).
    2.  Capacity increases **logarithmically** with Signal Power ($S$). This means doubling the power results in only a small increase in capacity—eventually, you hit diminishing returns.

---

## 3. Signal-to-Noise Ratio (SNR)

SNR measures the strength of the desired signal relative to background noise. It is typically expressed on a logarithmic scale in **Decibels (dB)**.
$$SNR_{dB} = 10 \log_{10}(\frac{\text{Signal Power}}{\text{Noise Power}})$$

| SNR (dB) | Ratio ($S/N$) | Channel Quality |
| :--- | :--- | :--- |
| **0 dB** | 1:1 | Unusable (Noise = Signal) |
| **10 dB** | 10:1 | Poor |
| **30 dB** | 1000:1 | Excellent |

---

## 4. Signal Impairments

*   **Attenuation**: Signal power decreases with distance. High-frequency signals attenuate faster than low-frequency ones.
*   **Noise**:
    *   **Thermal Noise**: Random electron motion (white noise); present in all conductors.
    *   **Crosstalk**: Unwanted coupling between adjacent wires.
    *   **Impulse Noise**: Sudden, high-power spikes (e.g., from lightning or power lines).
*   **Distortion**: Different frequencies travel at different speeds through the medium, causing the signal "shape" to smear.
*   **Multipath**: In wireless, the same signal arrives via multiple paths (reflections), causing self-interference and fading.
