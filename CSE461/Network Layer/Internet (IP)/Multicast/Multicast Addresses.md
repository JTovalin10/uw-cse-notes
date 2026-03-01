# Multicast Addresses

## Address allocation

- **[[IPv4]]**: [[IP Address Classes (Classful Addressing)|Class D]] address space
- **[[IPv6]]**: Reserved portion of address space
- Some subranges reserved for intradomain (reusable per domain)

## IPv4 → Ethernet mapping

- **IPv4 multicast: 28 bits** — [[IP Address Classes (Classful Addressing)|Class D]] addresses (224.0.0.0–239.255.255.255) have a fixed 4-bit prefix (1110). The remaining **28 bits** identify the multicast group.
- **Ethernet multicast: 23 bits** — Ethernet uses the reserved prefix `01:00:5E`; only **23 bits** of the 48-bit MAC are available for mapping (a cost-saving decision: one **OUI** — Organizationally Unique Identifier, a 24-bit IEEE-assigned MAC prefix — purchased instead of 16, which would have given full 28-bit mapping).
- **Mapping**: Copy the **low-order 23 bits** of the IPv4 multicast address into the Ethernet address. The **high-order 5 bits** of the 28-bit group ID are dropped.
- **Result**: $2^5 = 32$ IP multicast addresses map to each Ethernet address — any two IP groups whose low 23 bits match will share the same MAC.

## Consequence

- Host joining group G may receive traffic for 31 other groups that share the same Ethernet address
- IP layer must filter at receiving host
- [[Switched Network|Switched]] Ethernet can mitigate ([[Switch|switches]] discard unwanted packets)

## Learning addresses

- Senders/receivers learn which multicast addresses to use via **out-of-band** means — group addresses come from applications, config, or service discovery (e.g., SDP), not from the network itself
- Tools exist to advertise group addresses on the Internet
