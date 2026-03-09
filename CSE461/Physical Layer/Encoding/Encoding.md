# Encoding & Modulation

**Encoding** and **Modulation** are the techniques used to map digital bits onto physical signals. **Encoding** typically refers to **Baseband** transmission (mapping bits to discrete voltage levels), while **Modulation** refers to **Passband** transmission (shifting data onto a higher-frequency carrier wave).

## Low-Level Primer: Baseband Encoding
Baseband signals occupy frequencies starting from 0 Hz.

### 1. Non-Return to Zero (NRZ)
Maps `1` to High voltage and `0` to Low voltage.
*   **Problem: Baseline Wander**: Receiver tracks a running average to distinguish levels. Long strings of same-bits skew the average.
*   **Problem: Clock Recovery**: No transitions during long same-bit strings make it impossible for the receiver to stay in sync.

### 2. NRZ Inverted (NRZI)
Transition on `1`, no transition on `0`. Solves clock recovery for strings of `1`s, but not `0`s.

### 3. Manchester Encoding
Transmits the XOR of the bit and the clock.
*   **Benefit**: A transition occurs in the middle of every bit period, ensuring perfect clock recovery.
*   **Drawback**: **Doubles the Baud Rate** (requires twice the bandwidth) compared to NRZ.

### 4. 4B/5B Encoding
Maps every 4 bits of data into a 5-bit codeword.
*   **Design**: Codewords are chosen so there are never more than three consecutive `0`s. 
*   **Efficiency**: 80% (only 1 bit of overhead for every 4). It is then sent using NRZI to ensure frequent transitions.

[Image: Waveform comparison of NRZ, NRZI, and Manchester encoding]

---

## Passband Modulation
Used for wireless, fiber, and cable where data must be shifted to a specific frequency band.

### 1. Basic Schemes
*   **ASK (Amplitude Shift Keying)**: Vary the signal strength.
*   **FSK (Frequency Shift Keying)**: Vary the signal frequency.
*   **PSK (Phase Shift Keying)**: Vary the signal starting phase.

### 2. Advanced: QAM (Quadrature Amplitude Modulation)
Combines **ASK** and **PSK** to pack multiple bits into a single symbol.
*   **16-QAM**: 4 bits per symbol.
*   **64-QAM**: 6 bits per symbol (used in LTE/WiFi).
*   **256-QAM**: 8 bits per symbol.

[Image: QAM Constellation diagram showing symbols in a 2D plane]

---

## Clock Recovery
The process of synchronizing the receiver's sampling clock with the sender's.
*   **PLL (Phase-Locked Loop)**: Hardware that tracks signal transitions to adjust the local clock.
*   **Self-Clocking Codes**: Schemes like Manchester or 4B/5B that guarantee enough transitions for the PLL to stay locked.

## Related Topics
*   **[[Nyquist Limit]]**: Constrains the max symbol rate.
*   **[[Shannon Capacity]]**: Constrains the bits per symbol based on noise.
*   **[[Physical Layer]]**: The broader hardware context.
