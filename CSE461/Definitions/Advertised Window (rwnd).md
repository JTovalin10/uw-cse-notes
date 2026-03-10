# Advertised Window (rwnd)

## Low-Level Primer: End-to-End Flow Control
The **Advertised Window (rwnd)**, also known as the **Receiver Window**, is a TCP header field used by the receiver to inform the sender of its current available buffer space. It is the fundamental mechanism for **[[Transport Layer - Transmission Control Protocol (TCP)#Flow Control: The Sliding Window|Flow Control]]**.

The goal of **rwnd** is to prevent a fast sender from overwhelming a slow receiver by sending more data than the receiver's application can process.

---

## Technical Mechanics

In every **[[Acknowledgment (ACK)]]** sent back to the sender, the receiver includes the current size of its free buffer in the `Window` field of the TCP header.

### The Flow Control Invariant
The sender must ensure that the amount of unacknowledged data does not exceed the most recently received advertised window:
$$\text{LastByteSent} - \text{LastByteAcked} \le \text{rwnd}$$

### Corner Cases
*   **Zero Window**: If the receiver's buffer is full, it advertises `rwnd = 0`. The sender stops transmitting and periodically sends 1-byte **Zero Window Probes** to check if space has opened up.
*   **[[Silly Window Syndrome]]**: Occurs when the receiver advertises tiny increases in the window (e.g., 1 byte), leading to massive overhead. Clark's Algorithm and Nagle's Algorithm are used to mitigate this.

---

## Relation to cwnd
While **rwnd** protects the **Receiver**, the **[[Congestion Window (cwnd)]]** protects the **Network**. The sender uses the minimum of the two to determine the actual amount of data to send:
$$\text{Allowed Window} = \min(\text{cwnd}, \text{rwnd})$$
