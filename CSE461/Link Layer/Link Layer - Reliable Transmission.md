# Link Layer: Reliable Transmission (ARQ)

## Low-Level Primer: The Reliability Duality
While some link-layer technologies (e.g., Fiber Ethernet) assume a near-perfect channel and omit reliability, others (e.g., Wi-Fi, Satellite) operate over lossy mediums where frame corruption is common. To handle this, the **[[Link Layer]]** implements **[[Automatic Repeat Request (ARQ)]]**, a mechanism that uses feedback from the receiver to ensure every frame eventually arrives intact.

Reliability at the link layer serves three primary roles:
1.  **Error Recovery**: Retransmitting lost or corrupted frames.
2.  **Ordered Delivery**: Ensuring frames are passed to the **[[Network Layer]]** in the same order they were sent.
3.  **Flow Control**: Preventing a fast sender from overwhelming a slow receiver's buffer.

---

## 1. Automatic Repeat Request (ARQ) Components

The ARQ system relies on two fundamental control signals:
*   **[[Acknowledgment (ACK)]]**: A small control frame sent by the receiver to confirm the successful arrival of a data frame.
*   **Retransmission Timeout (RTO)**: A timer at the sender. If an ACK is not received before the timer expires, the sender assumes the frame was lost and resends it.

---

## 2. Stop-and-Wait ARQ

The simplest reliability mechanism. The sender transmits one frame and waits for an ACK before sending the next.

### Duplicate Detection (1-Bit Sequence Numbers)
If an ACK is lost, the sender will retransmit the original frame. To prevent the receiver from delivering this duplicate to the upper layer, each frame carries a **1-bit sequence number** (alternating $0$ and $1$).
*   If the receiver sees two consecutive frames with the same sequence number, it discards the second one but still sends an ACK (in case the previous ACK was lost).

### Efficiency Limitation
Stop-and-Wait is highly inefficient on links with a large **[[Bandwidth-Delay Product]]**.
*   **Utilization ($U$)**: The fraction of time the sender is busy.
    $$U = \frac{T_{trans}}{T_{trans} + RTT}$$
*   On high-latency links (e.g., satellite), $RTT \gg T_{trans}$, causing $U$ to approach zero as the sender sits idle waiting for ACKs.

---

## 3. Sliding Window ARQ

Generalizes Stop-and-Wait by allowing multiple frames to be "in flight" simultaneously, keeping the "pipe" full.

### Sender-Side State (SWS)
*   **SWS (Send Window Size)**: Max number of unacknowledged frames allowed.
*   **LAR (Last ACK Received)**: Sequence number of the latest cumulatively acknowledged frame.
*   **LFS (Last Frame Sent)**: Sequence number of the most recently transmitted frame.
*   **Invariant**: $LFS - LAR \le SWS$.

### Receiver-Side State (RWS)
*   **RWS (Receive Window Size)**: Max number of out-of-order frames the receiver will buffer.
*   **LFR (Last Frame Received)**: Sequence number of the latest in-order frame received.
*   **LAF (Largest Acceptable Frame)**: The upper bound of the receive window.
*   **Invariant**: $LAF - LFR \le RWS$.

---

## 4. Retransmission Strategies

| Strategy | Receiver Behavior | Sender Behavior | Efficiency |
| :--- | :--- | :--- | :--- |
| **Go-Back-N** | Discards all out-of-order frames ($RWS=1$). | On timeout, retransmits the lost frame **and all subsequent** frames in the window. | Low (redundant work). |
| **Selective Repeat** | Buffers out-of-order frames ($RWS=SWS$). | On timeout, retransmits **only** the specific missing frame. | High. |

### Sequence Number Constraint
To prevent the receiver from confusing a new frame with a delayed retransmission from a previous window, the sequence number space must be large enough:
$$\text{MaxSeqNum} + 1 \ge SWS + RWS$$
If $SWS = RWS$, then $SWS < \frac{\text{MaxSeqNum} + 1}{2}$.

---

## 5. Flow Control: The Advertised Window

If the receiving application (e.g., a web server) is slow at reading data, the link-layer buffer will fill up. 
*   **Mechanism**: The receiver includes an **Advertised Window (WIN)** in its ACKs, specifying the remaining buffer space.
*   **Sender Response**: The sender must ensure that the number of in-flight bytes never exceeds the receiver's `WIN`.

---

## 6. Technical Implementation (C Structure)

```c
typedef struct {
    /* Sender State */
    SeqNum  LAR;        /* Last ACK Received */
    SeqNum  LFS;        /* Last Frame Sent */
    Slot    sendQ[SWS]; /* Buffer for retransmission */

    /* Receiver State */
    SeqNum  NFE;        /* Next Frame Expected (LFR + 1) */
    Slot    recvQ[RWS]; /* Buffer for out-of-order arrival */
} SwpState;
```

[Image: Sequence diagram showing Sliding Window recovery from a single lost frame]
