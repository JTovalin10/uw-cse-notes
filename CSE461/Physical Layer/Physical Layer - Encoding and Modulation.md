# Physical Layer: Encoding and Modulation

## Low-Level Primer: From Bits to Symbols
At the most granular level, digital data (0s and 1s) must be represented as discrete levels of a physical property (voltage, light intensity, or radio phase). This process is divided into **Encoding** (Baseband) and **Modulation** (Passband).

---

## 1. Digital Baseband Encoding (Line Coding)

Line coding maps binary digits directly into a discrete-time signal.

### Non-Return to Zero (NRZ)
Maps `1` to High voltage and `0` to Low voltage.
*   **The Problem (Baseline Wander)**: Long strings of $0$s or $1$s shift the average DC voltage, making it hard for the receiver to distinguish the signal from noise.
*   **The Problem (Clock Recovery)**: Without transitions, the receiver's clock drifts relative to the sender's, leading to bit errors.

### NRZ Inverted (NRZI)
A transition represents a `1`, while no transition represents a `0`. 
*   **Benefit**: Solves the clock recovery problem for strings of $1$s.
*   **Failure**: Still fails on long strings of $0$s.

### Manchester Encoding
Guarantees a transition in the middle of every bit period (XOR of data and clock).
*   **Benefit**: Perfect clock recovery.
*   **Drawback**: **Doubles the Baud Rate** (requires twice the bandwidth of NRZ).

### Block Coding (4B/5B)
A compromise used in 100 Mbps Ethernet.
*   **Mechanism**: Maps every 4 bits of data into a 5-bit code chosen to ensure no more than one leading zero and no more than two trailing zeros.
*   **Transmission**: The 5-bit patterns are sent using **NRZI**, ensuring enough transitions for the clock to stay locked without the 50% efficiency loss of Manchester.

![[Screenshots/Binary Padding 4,5.png]]

---

## 2. Passband Modulation

Used when the signal must be shifted to a higher frequency band (e.g., radio, fiber).

### Basic Keying Schemes
*   **ASK (Amplitude Shift Keying)**: Vary signal strength.
*   **FSK (Frequency Shift Keying)**: Vary signal frequency.
*   **PSK (Phase Shift Keying)**: Vary the starting phase of the sine wave.

### Multi-Level Signaling (QAM)
To increase the data rate without increasing the signal frequency, we use multiple voltage levels or phases to pack more bits into a single **Symbol**.
*   **Baud Rate**: The number of symbol changes per second.
*   **Bit Rate**: $\text{Baud Rate} \times \log_2(\text{Number of Levels})$.
*   **16-QAM**: Uses 16 distinct combinations of amplitude and phase to send 4 bits per symbol.

---

## 3. Clock Recovery Mechanisms

The receiver must sample the incoming signal at exactly the right moments to avoid "Bit Slip."

*   **Self-Clocking Signals**: Codes like Manchester and 4B/5B provide frequent transitions that allow the receiver to re-sync.
*   **Phase-Locked Loop (PLL)**: A hardware circuit that tracks incoming transitions and adjusts the local oscillator to match the sender's phase.
*   **Scrambling**: XORing data with a pseudo-random sequence to ensure a high density of transitions, regardless of the user's data pattern (used in SONET).

[Image: Block diagram of a Phase-Locked Loop (PLL) synchronization circuit]
