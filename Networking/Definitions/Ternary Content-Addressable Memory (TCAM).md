## Ternary Content-Addressable Memory (TCAM)
A specialized memory that stores bit patterns and can match them against packet header fields in a single clock cycle. Each entry can match on 0, 1, or "don't care" (the ternary part), making it ideal for longest-prefix-match lookups in [[Forwarding Table|forwarding tables]].

Used in [[Hardware Switch|hardware switches]] alongside [[Static Random-Access Memory (SRAM)|SRAM]] for high-speed packet processing.
