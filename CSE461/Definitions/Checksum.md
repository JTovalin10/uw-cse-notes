## Checksum
An error detection mechanism where the sender computes a value from the data and includes it in the packet header. The receiver recomputes the checksum over the received data and compares it to the included value. If they differ, the data has been corrupted in transit.

IP uses a ones' complement checksum computed over the header only (not the payload). Higher-layer protocols like [[Transmission Control Protocol (TCP)|TCP]] and [[User Datagram Protocol (UDP)|UDP]] compute checksums over both headers and data.

See also: [[CSE461/Link Layer/Error Detection and Correction/Checksum]]
