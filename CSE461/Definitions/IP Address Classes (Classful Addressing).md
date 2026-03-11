# IP Address Classes (Classful Addressing)

Obsolete [[IPv4]] addressing scheme (1981–1993) that divided the 32-bit address space into **five fixed classes** based on the leading bits. Replaced by [[Classless Interdomain Routing (CIDR)]] for flexible, variable-length prefixes.

## The five classes

| Class | Leading bits | Network bits | Host bits | First octet | Networks | Hosts each | Mask / use |
|-------|--------------|--------------|-----------|-------------|----------|------------|-------------|
| **A** | 0 | 8 | 24 | 1–126* | 126 | ~16.7M | 255.0.0.0 (/8) |
| **B** | 10 | 16 | 16 | 128–191 | 16,384 | ~65K | 255.255.0.0 (/16) |
| **C** | 110 | 24 | 8 | 192–223 | ~2M | 254 | 255.255.255.0 (/24) |
| **D** | 1110 | — | — | 224–239 | — | — | [[Multicast Overview]] |
| **E** | 1111 | — | — | 240–255 | — | — | Reserved / experimental |

\* Class A: 0 and 127 reserved (0.0.0.0 = "this host"; 127.x.x.x = loopback)

## Why it was replaced

- **Wasteful** — Class A gave 16M addresses per network; most orgs needed far fewer
- **Rigid** — Only three sizes (A, B, C); no /20, /21, etc.
- **Exhaustion** — Led to [[IPv4]] address shortage

[[Classless Interdomain Routing (CIDR)]] fixes this with variable-length prefixes (e.g., /24, /19) and [[Longest matching prefix|longest prefix match]].

## See also

- [[Classless Interdomain Routing (CIDR)]] — what replaced it
- [[IPv4]] — 32-bit addressing
- [[Multicast Addresses]] — Class D in use for multicast


![[Screenshots/IP addressess (classes).png]]
