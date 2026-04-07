# CSE452: Deterministic State Machine

In the labs, this is called **Application**.

## What is a Deterministic State Machine?

A **Deterministic State Machine (DSM)** is a formal model for the application logic running on each replica. It has:

- **States**: the full set of possible machine states (possibly infinite — e.g., the contents of a key-value store)
- **Inputs** (called **Commands**): operations sent to the machine
- **Outputs** (called **Results**): the response produced for each command
- **Determinism**: given equal states and equal inputs, the machine produces equal outputs *and* transitions to the same next state

$$\text{State} \times \text{Command} \rightarrow \text{Result} \times \text{State}'$$

## Why Determinism Matters for Replication

If all replicas start in the same state and receive the same commands in the same order, they will reach the same state and produce the same outputs. This is the foundation of replication:

> **Replicate a deterministic state machine by feeding all replicas the same ordered sequence of commands.**

This is why ordering matters so much in [[CSE452/Primary-Backup/Primary Backup|Primary-Backup]] — the primary's job is to decide and enforce the order of commands.

---

## Related
- [[CSE452/Primary-Backup/Primary Backup|Primary-Backup Replication]] — uses the DSM model: same commands in same order → same state
- [[CSE452/RPC/Remote Procedure Call (RPC)|Remote Procedure Call (RPC)]] — the mechanism for delivering commands to replicas
- [[CSE452/RPC/Fault Model|Fault Model]] — what can go wrong when delivering commands
