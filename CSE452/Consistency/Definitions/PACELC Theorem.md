# PACELC Theorem

**[[PACELC Theorem]]**: An extension of the CAP theorem that describes the trade-offs in a distributed system during both partitioned and normal operation.

## Definition
- **P** (During Partition): Choose between **A** (Availability) and **C** (Consistency).
- **E** (Else/Normal Operation): Choose between **L** (Latency) and **C** (Consistency).

This theorem acknowledges that even without network failures, there is a cost to consistency: it takes time (latency) to coordinate between nodes.

## Related
- [[CSE452/Consistency/Definitions/CAP Theorem|CAP Theorem]]
