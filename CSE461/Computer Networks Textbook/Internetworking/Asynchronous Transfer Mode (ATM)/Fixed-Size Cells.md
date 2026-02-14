ATM uses fixed 53-byte **cells** (5-byte header + 48-byte payload) instead of variable-length packets. This enables hardware-based switching:
- Simpler to build hardware when every unit is the same length
- Many [[Switch]] elements can process cells **in parallel** since they're all doing the same thing on identically-sized data

The downside is [[Cell Tax]] — wasted bandwidth from padding small payloads and splitting large ones.
