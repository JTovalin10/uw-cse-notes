# Link Layer: Framing and Encapsulation

## Low-Level Primer: Defining Frame Boundaries
The **[[Physical Layer]]** provides a continuous, unstructured stream of bits. The **[[Link Layer]]** must impose structure on this stream by dividing it into discrete units called **Frames**. Framing is the process of identifying the start and end of these units so that the receiver can correctly interpret the encapsulated data (typically **[[Internet Protocol (IP)|IP]]** packets).

---

## 1. Byte-Oriented Protocols (PPP)

These protocols view a frame as a collection of bytes.

### Sentinel-Based (Character Stuffing)
*   **Mechanism**: Uses special "Sentinel" characters to mark boundaries.
    *   **SYN**: Synchronize.
    *   **STX**: Start of Text.
    *   **ETX**: End of Text.
*   **The Problem**: The sentinel character might appear in the user data.
*   **The Fix (Byte Stuffing)**: If a sentinel character (or the escape character itself) appears in the payload, the sender inserts a special **Escape** character (e.g., `DLE` or a backslash) before it. The receiver identifies the escape and removes it, treating the following byte as literal data.

### Byte Counting
*   **Mechanism**: The frame header includes a field specifying the total number of bytes in the frame.
*   **The Problem (The "Misfortune")**: If a single bit error occurs in the **Count Field**, the receiver will misinterpret the frame's end. It will continue reading into the next frame's data, causing a **Framing Error** that can lead to the loss of multiple consecutive frames until a new synchronization marker is found.

---

## 2. Bit-Oriented Protocols (HDLC)

**HDLC (High-Level Data Link Control)** is the standard for bit-oriented framing, treating the frame as a raw sequence of bits regardless of byte boundaries.

### The Flag Sequence
Both the start and end of an HDLC frame are marked by the distinguished bit pattern: `01111110`.

### The Bit Stuffing Algorithm
To ensure the flag sequence never appears in the actual data, the protocol uses **Bit Stuffing**:
*   **Sender**: Any time the sender sees **five consecutive 1s** in the payload, it automatically inserts a `0` after them.
*   **Receiver**: If the receiver sees five consecutive 1s:
    *   If the next bit is `0`: It was a stuffed bit. **Discard the 0** and continue.
    *   If the next bit is `1`: Check the *following* bit.
        *   If `0`: It is the **End-of-Frame Marker** (`01111110`).
        *   If `1`: It is an **Error** (`01111111`). Discard the frame and wait for the next flag.

![[Screenshots/FLAG ESC padding.png]]
*Figure: HDLC frame structure with bit-stuffed payload*

---

## 3. Clock-Based Framing (SONET)

Used in high-speed optical networks (Fiber), **SONET** avoids bit stuffing to maintain a **Fixed Frame Size** (810 bytes for STS-1), making bandwidth and timing calculations perfectly predictable.

### Soft Synchronization
*   **Mechanism**: The receiver achieves "lock" by observing the sync pattern at regular 810-byte intervals.
*   **Hysteresis**: The receiver uses a state machine. It requires seeing the pattern correctly $N$ times to declare "in sync" and $M$ misses to declare "out of sync," preventing "bouncing" due to occasional bit errors.
*   **Scrambling**: The payload is XORed with a 127-bit pseudo-random pattern to ensure sufficient 0-to-1 transitions for clock recovery, regardless of the user data.

---

## 4. Ethernet Frame Format

Ethernet is the most dominant link-layer technology. It has evolved from a shared-medium (Classical) to a switched (Modern) architecture.

### Frame Structure (IEEE 802.3)
| Field | Size | Description |
| :--- | :--- | :--- |
| **Preamble** | 8 Bytes | 7 bytes of `10101010` followed by 1 byte of `10101011` to sync the receiver's clock. |
| **Dest Address** | 6 Bytes | The 48-bit **[[Media Access Control (MAC)|MAC Address]]** of the receiver. |
| **Src Address** | 6 Bytes | The 48-bit MAC address of the sender. |
| **Type / Length** | 2 Bytes | Identifies the higher-layer protocol (e.g., `0x0800` for IPv4). |
| **Payload** | 46-1500 B | The data (e.g., an IP packet). Minimum size of 46B ensures collision detection works. |
| **CRC** | 4 Bytes | A **[[Cyclic Redundancy Check (CRC)]]** for error detection. |

*Figure: Classical Ethernet frame format*

### Key Differences: Classical vs. Modern
*   **Classical Ethernet**: Shared bus; uses **[[CSMA-CD (Collision Detection)]]** to manage access. Frames are broadcast to everyone on the wire.
*   **Modern Ethernet**: Switched; uses point-to-point links. Collisions are eliminated by full-duplex switches, but the frame format remains compatible for interoperability.
