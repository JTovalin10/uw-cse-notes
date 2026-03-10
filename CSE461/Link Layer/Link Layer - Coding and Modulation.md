# Link Layer: Coding, Modulation, and Clock Recovery

## Low-Level Primer: From Bits to Symbols
At the most granular level, the **[[Link Layer]]** must interface with the **[[Physical Layer]]** to transmit digital data (0s and 1s) over an analog medium (copper wires, optical fibers, or radio waves). This process requires **Coding** (representing bits as a sequence of discrete levels) and **Modulation** (varying a carrier signal's frequency, amplitude, or phase).

---

## Digital Encoding (Line Coding)

Line coding is the process of mapping a sequence of binary digits into a discrete-time signal.

### 1. Non-Return to Zero (NRZ)
The simplest encoding scheme where a high voltage represents a `1` and a low voltage represents a `0`.
*   **Problem (Baseline Wander)**: Long strings of `0`s or `1`s cause the average DC voltage to shift, making it difficult for the receiver to distinguish the signal from noise.
*   **Problem (Clock Recovery)**: With no transitions, the receiver's clock can drift relative to the sender's, leading to bit errors.
*   **NRZ-Inverted (NRZI)**: A transition (high-to-low or low-to-high) represents a `1`, while no transition represents a `0`. This solves the long-string-of-1s problem but still fails on long strings of 0s.

### 2. Manchester Encoding
A more robust scheme where every bit period contains a transition.
*   **Mechanics**:
    *   `1`: High-to-low transition in the middle of the bit interval.
    *   `0`: Low-to-high transition.
*   **Benefit**: Guaranteed transition every bit ensures perfect **Clock Recovery**.
*   **Drawback**: Requires twice the bandwidth of NRZ (Baud Rate = 2 × Bit Rate).

### 3. Block Coding (4B/5B)
A compromise that ensures transitions without the 50% efficiency loss of Manchester.
*   **Mechanism**: Maps every 4-bit nibble into a 5-bit code.
*   **Constraint**: The 5-bit codes are chosen such that no code has more than one leading `0` or more than two trailing `0`s.
*   **Implementation**: The 5-bit patterns are then transmitted using **NRZI**.
*   **Efficiency**: 80% (5 bits sent for every 4 bits of data).

[Image: Comparison of NRZ, Manchester, and 4B/5B waveforms]

---

## Modulation and Symbol Rates

Modulation is used when the baseband signal must be shifted to a higher frequency for transmission (e.g., over radio or fiber).

### Multi-Level Signaling (Baud vs. Bit Rate)
To increase the data rate without increasing the signal frequency, we can use more than two voltage levels.
*   **Baud Rate (Symbol Rate)**: The number of times the signal changes per second.
*   **Bit Rate**: The number of bits transmitted per second.
*   **Relationship**: $\text{Bit Rate} = \text{Baud Rate} \times \log_2(L)$, where $L$ is the number of discrete levels.

### Example: 4-Level Pulse Amplitude Modulation (PAM-4)
By using four distinct voltage levels, we can represent two bits per symbol:
| Voltage Level | Binary Symbol |
| :--- | :--- |
| **0.0 V** | `00` |
| **1.0 V** | `01` |
| **2.0 V** | `10` |
| **3.0 V** | `11` |

---

## Clock Recovery Mechanisms

The receiver must sample the incoming signal at exactly the right moments.

*   **Self-Clocking Signals**: Manchester and 4B/5B/NRZI provide enough transitions to allow the receiver to synchronize its clock to the sender's.
*   **Phase-Locked Loop (PLL)**: A circuit in the **[[Network Interface Card (NIC)]]** that tracks the incoming transitions and adjusts the sampling clock to stay in phase.
*   **Scrambling**: XORing the data with a pseudo-random bitstream to ensure a high density of transitions, regardless of the original data pattern.

[Image: Block diagram of a Clock Recovery Phase-Locked Loop (PLL)]
