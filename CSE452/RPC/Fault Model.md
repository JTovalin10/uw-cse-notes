# CSE452: Fault Model

## What is a Fault Model?

A **fault model** is a formal list of the failures a protocol is designed to tolerate automatically. It answers two questions:
- What failures are *possible*?
- Which of those failures does this system *plan to handle*?

A protocol is **correct** if, for any execution and any failure within the fault model, it produces the advertised behavior. See [[CSE452/RPC/Remote Procedure Call (RPC)|RPC]] for how this applies to protocols.

---

## Failure Assumptions: Fail-Stop vs. Byzantine

The type of failures assumed dramatically affects how complex a protocol must be:

| Assumption | Description | What the machine can do |
|------------|-------------|------------------------|
| **Fail-stop (crash-stop)** | A machine either works correctly or stops entirely — no in-between | Correct output, or no output |
| **Byzantine failures** | A machine can behave arbitrarily — send wrong data, lie about state, act maliciously | Anything, including actively wrong responses |

**CSE452 assumes fail-stop failures.** Machines either run correctly or crash. They do not send incorrect data, corrupt messages, or behave deceptively. This simplification is realistic for datacenter environments (hardware failures and software crashes, not adversarial nodes) and allows much simpler protocols.

Tolerating Byzantine failures requires more complex protocols (e.g., PBFT, BFT variants of Paxos/Raft) and is out of scope.

## Types of Failures

### Machine Crashes
- A machine stops operating entirely (fail-stop)
- The machine may restart later, but its in-memory state is lost
- Durable state (disk) survives a crash; in-memory state does not

### Network Failures

Network failures are particularly tricky because they are **invisible to the sender** — neither side knows for sure what happened.

- **Dropped messages**: a packet is lost in transit
  - The client has no way to know whether the server received it or whether the server or network dropped it
  - Standard response: the client **retransmits**
  - This creates a problem for **writes**: retransmitting a write may apply the same write twice if the first attempt actually succeeded

- **Delayed or reordered messages**: a packet arrives late or out of order relative to other packets
  - A system must not assume messages arrive in send order

- **Duplicate messages**: a packet is delivered more than once by the network
  - Even without explicit retransmission, the network can duplicate packets
  - Combined with client retransmission, duplicates are common — see [[CSE452/RPC/Remote Procedure Call (RPC)#Request ID and Deduplication|RPC deduplication]]

---

## Related
- [[CSE452/RPC/Introduction to DS|Introduction to Distributed Systems]] — why faults make DS hard
- [[CSE452/RPC/Remote Procedure Call (RPC)|Remote Procedure Call (RPC)]] — how RPC handles dropped/duplicate messages
- [[CSE452/Primary-Backup/Failover Protocol|Failover Protocol]] — responding to machine crashes
- [[CSE452/Primary-Backup/Primary Backup|Primary-Backup Replication]] — tolerating machine failures via replication
