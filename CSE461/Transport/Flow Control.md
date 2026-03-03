# Flow Control

Mechanisms to prevent the sender from overwhelming the receiver. The receiver has limited buffer space; if the sender transmits too fast, the receiver drops data.

## Approaches

- [[Stop-and-Wait]] — single frame at a time; simplest but inefficient
- [[Sliding Window]] — multiple frames in flight; receiver advertises available buffer space (WIN)

## Related

- [[Transmission Control Protocol (TCP)]] — uses advertised window for flow control
- [[ACK Clocking]] — ACKs pace transmission
