# CSE452: Why Not Just Use TCP?

## What TCP Promises

**TCP** (Transmission Control Protocol) provides:
- **Ordered** message delivery
- **Reliable** message delivery (retransmission on loss)

This sounds like exactly what a distributed system needs. So why not just use TCP and call it done?

---

## The Problem: TCP Does Not Handle Failures Well

TCP is designed for the common case — when the network is healthy, it works great and is more efficient than application-level networking. But when a real failure occurs, TCP falls short:

### Disconnection Scenarios
- **Network cuts out**: TCP retransmits but eventually gives up and closes the connection
- **Machine crashes**: TCP has no way to distinguish a crashed server from a slow one

### TCP's Response to Failure
Upon detecting a failure (via timeout), TCP will:
1. Attempt to reconnect/retransmit
2. After the **timeout window** expires, close the connection entirely

The application is left with a closed socket and no information about whether the last messages were received and processed. This ambiguity is fatal for distributed system correctness — especially for **write operations**, where you need to know definitively whether the write was applied.

---

## Why Application-Level Protocols Are Needed

A distributed system needs application-level mechanisms that TCP does not provide:
- **Explicit sequence numbers** to detect duplicates and gaps (see [[CSE452/RPC/Remote Procedure Call (RPC)#Request ID and Deduplication|RPC deduplication]])
- **Failure detection** separate from connection state (see [[CSE452/Primary-Backup/Failover Protocol|Failover Protocol]])
- **At-Least-Once / Exactly-Once semantics** (see [[CSE452/RPC/Remote Procedure Call (RPC)#Types of RPC|Types of RPC]])

TCP is a building block — it removes *most* network unreliability — but it does not provide the fault-tolerance guarantees that distributed systems require.

---

## Related
- [[CSE452/RPC/Fault Model|Fault Model]] — the failure scenarios TCP cannot handle
- [[CSE452/RPC/Remote Procedure Call (RPC)|Remote Procedure Call (RPC)]] — the application-level protocol built on top of TCP
- [[CSE452/Primary-Backup/Primary Backup|Primary-Backup Replication]] — a full fault-tolerant protocol that goes beyond TCP
- [[CSE461/Transport/Transport Layer - Transmission Control Protocol (TCP)|TCP (CSE461)]] — full TCP protocol details
