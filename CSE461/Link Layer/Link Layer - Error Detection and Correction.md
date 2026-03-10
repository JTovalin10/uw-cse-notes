# Link Layer: Error Detection and Correction

## Low-Level Primer: The Necessity of Redundancy
Physical communication channels are inherently noisy. Thermal noise, electromagnetic interference, and signal attenuation can cause bits to flip ($0 \to 1$ or $1 \to 0$) during transmission. To achieve reliability, the **[[Link Layer]]** adds **Redundancy**: extra bits appended to the data that allow the receiver to verify integrity.

*   **Detection**: The ability to determine that an error occurred (requires retransmission).
*   **Correction**: The ability to identify the exact location of the error and flip it back (Forward Error Correction - FEC).

---

## Hamming Distance ($d$)

The **[[Hamming Distance]]** is the fundamental metric for evaluating the strength of an error code.

*   **Definition**: The number of bit positions in which two codewords differ.
*   **Code Distance**: The *minimum* Hamming distance between any two valid codewords in a coding scheme.
*   **Detection Power**: A code with distance $d$ can detect up to $d-1$ bit errors.
*   **Correction Power**: A code with distance $d$ can correct up to $\lfloor \frac{d-1}{2} \rfloor$ bit errors.

---

## 1. Parity Bits

The simplest form of error detection.

### One-Dimensional Parity
*   **Mechanism**: Add a single bit to $D$ data bits such that the total number of $1$s is even (Even Parity) or odd (Odd Parity).
*   **Distance**: $d=2$.
*   **Capability**: Detects all single-bit errors and all odd numbers of bit errors. Fails to detect even numbers of errors (e.g., 2 bits flipping).

### Two-Dimensional Parity
*   **Mechanism**: Arrange data bits in a grid and calculate parity for each row and each column.
*   **Distance**: $d=4$.
*   **Capability**: Detects all 1, 2, and 3-bit errors. Corrects all single-bit errors (the intersection of the row and column parity failures identifies the exact bit).

[Image: 2D parity grid showing row and column parity bits]

---

## 2. Internet Checksum

Used primarily in the **[[Transport Layer]]** (TCP/UDP) and **[[Network Layer]]** (IP), though relevant to the study of error codes.

### Technical Mechanics
1.  Treat data as a sequence of 16-bit integers.
2.  Sum the integers using **1's Complement Arithmetic** (any carry-over bit is added back to the least significant bit).
3.  The checksum is the bitwise NOT (complement) of the final sum.
4.  **Verification**: The receiver sums all data + the checksum. If the result is all $1$s (or $0$ in some implementations), no error is detected.

### Evaluation
*   **Pros**: Extremely fast to compute in software.
*   **Cons**: Mathematically weak. Fails to detect byte swaps or errors that increment one word while decrementing another by the same amount.

---

## 3. Cyclic Redundancy Check (CRC)

The standard for high-performance hardware detection (e.g., Ethernet, Wi-Fi).

### Mathematical Foundation
CRC treats bitstrings as coefficients of a polynomial in a **Finite Field** ($GF(2)$).
*   Example: `1011` $\to x^3 + x^1 + x^0$.
*   Sender and receiver agree on a **Generator Polynomial** $C(x)$ of degree $k$.

### The Algorithm
1.  **Append**: Add $k$ zeros to the end of the message $M(x)$.
2.  **Divide**: Perform polynomial long division of the message by $C(x)$ using **XOR** instead of subtraction.
3.  **Remainder**: The $k$-bit remainder is the CRC.
4.  **Transmit**: Send $M(x) + \text{Remainder}$.

### Detection Properties
CRC can detect:
*   All single-bit errors (if $x^k$ and $x^0$ terms are non-zero).
*   All double-bit errors (if $C(x)$ has a factor with at least 3 terms).
*   Any odd number of errors (if $C(x)$ contains the factor $(x+1)$).
*   Any burst error of length $L \le k$.

![[Pasted image 20260207010035.png]]
*Figure: Example of CRC polynomial division*

---

## 4. Hamming Code (Forward Error Correction)

A specific construction used to achieve a distance of $d=3$, allowing for single-bit error correction.

### Construction (Encoding)
1.  Number bit positions starting from 1.
2.  Positions that are powers of 2 ($1, 2, 4, 8, \dots$) are **Check Bits**.
3.  All other positions are **Data Bits**.
4.  Each Check Bit at position $p$ covers all bit positions whose binary representation has a $1$ in the same bit-place as $p$.
    *   Example: Bit 1 covers 1, 3, 5, 7, 9... (all odd numbers).
    *   Example: Bit 2 covers 2, 3, 6, 7, 10...

### Decoding and Syndrome
The receiver recomputes the check bits. The **Syndrome** is formed by arranging the parity check results.
*   If Syndrome = 0: No error.
*   If Syndrome $\ne 0$: The value of the syndrome is the **exact bit position** that was flipped.

---

## Detection vs. Correction Trade-offs

| Factor | Detection (CRC/Checksum) | Correction (Hamming/RS) |
| :--- | :--- | :--- |
| **Overhead** | Low (few check bits) | High (many redundant bits) |
| **Use Case** | Low-error links (Fiber/Copper) | High-error links (Wireless/Satellite) |
| **Strategy** | Discard and Retransmit | Repair in-place |
| **Latency** | Higher (wait for retransmission) | Lower (instant repair) |
