## Cyclic Redundancy Check (CRC)
An error detection code based on polynomial division. The sender treats the message as a polynomial and divides it by a predetermined **generator polynomial**, appending the remainder to the message. The receiver performs the same division — if the remainder is non-zero, the data is corrupted.

- More powerful than a simple [[Checksum]] — can detect all burst errors up to the length of the generator polynomial
- Common variant: CRC-32 (used in Ethernet frames)

See also: [[CSE461/Link Layer/Error Detection and Correction/Cyclic Redundancy Check (CRC)]]
