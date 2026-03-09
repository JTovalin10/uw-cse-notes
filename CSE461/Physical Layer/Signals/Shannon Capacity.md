# Signals & Channel Capacity

To transmit data, digital bits must be mapped to physical signals. A channel's ability to carry information is fundamentally limited by its **Bandwidth** (frequency range) and its **Noise** level.

## Low-Level Primer: Signal Representation
*   **Time Domain**: Signal amplitude vs. time.
*   **Frequency Domain**: A signal viewed as a sum of sine waves at different frequencies (Fourier Transform).
*   **Bandwidth ($B$)**: The width of the frequency range (in Hz) that can pass through a channel with minimal attenuation.

---

## Fundamental Capacity Limits

### 1. Nyquist Limit (Noiseless Channels)
Defines the maximum bit rate for a channel with no noise, where the only constraint is the ability to distinguish between signal levels.
$$\text{Max Rate} = 2B \log_2 V \text{ (bps)}$$
*   **$B$**: Bandwidth in Hz.
*   **$V$**: Number of discrete signal levels (e.g., binary $V=2$).
*   **Baud Rate**: The rate at which symbols (signal changes) are sent. The bit rate is $\text{Baud} \times \text{bits per symbol}$.

### 2. Shannon-Hartley Theorem (Noisy Channels)
Defines the absolute maximum error-free bit rate for a real-world channel with noise.
$$\text{Capacity} = B \log_2(1 + \frac{S}{N}) \text{ (bps)}$$
*   **$S/N$**: **Signal-to-Noise Ratio (SNR)**.
*   **Decibel Scale**: SNR is usually expressed in dB: $SNR_{dB} = 10 \log_{10}(\frac{S}{N})$.
*   **Key Insight**: 
    *   Capacity increases **linearly** with bandwidth.
    *   Capacity increases **logarithmically** with signal power. This leads to diminishing returns when trying to increase speed by just increasing power.

[Image: Graph comparing Nyquist and Shannon limits relative to SNR]

---

## Signal Impairments
*   **Attenuation**: Signal strength decreases with distance. Higher frequencies attenuate faster.
*   **Distortion**: Different frequencies travel at different speeds, causing the signal shape to change.
*   **Noise**: 
    *   **Thermal**: Random electron motion (white noise).
    *   **Crosstalk**: Interference from adjacent wires.
    *   **Impulse**: Sudden spikes from external events (e.g., lightning, power surges).

## Related Topics
*   **[[Modulation]]**: The process of altering a carrier signal to encode data.
*   **[[Encoding]]**: Mapping bits to voltage levels or symbols.
*   **[[Error Detection and Correction]]**: Necessary when $S/N$ is too low to maintain the Shannon limit.
