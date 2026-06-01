## Automatic Repeat Request (ARQ)
A class of reliable transmission protocols where the receiver automatically acknowledges correct frames with an [[Acknowledgment (ACK)|ACK]], and the sender retransmits any frame that is not acknowledged within a timeout period.

Two main strategies:
1. **Stop-and-Wait** — send one frame, wait for ACK before sending the next
2. **[[Sliding Window Protocol]]** — send multiple frames before waiting for ACKs, improving throughput
