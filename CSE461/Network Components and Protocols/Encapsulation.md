# What is it
Encapsulation is the mechanism used to effect protocol layering 
	- Lower layer wraps higher layer content, adding its own information to make a new message for delivery
	- Like sending a letter in an envelope; postal service doesn’t look inside
![[Screenshot 2026-01-09 at 1.03.48 PM.png]]
It then gets unwrapped

# Typical drawing for class
![[Screenshot 2026-01-09 at 1.04.24 PM.png]]

# PDU Names at Each Layer
Each layer has its own name for the data unit:
| Layer | PDU Name |
|-------|----------|
| Application | Message/Data |
| Transport | Segment (TCP) / Datagram (UDP) |
| Network | Packet |
| Link | Frame |
| Physical | Bits |

# Header vs Trailer
- **Header**: added at the front of the payload (most common)
- **Trailer**: added at the end (used by Link layer for error detection, e.g., CRC)



# Related
- [[Layering]]
- [[Protocols and Layers]]
- [[OSI Layers]]