# CSE452: Reconfiguration

**Reconfiguration** is the process of updating the system state when the **[[ShardMaster|ShardMaster]]** issues a new **[[Configuration|Configuration]]**. This requires **[[Replica Group|Replica Groups]]** to hand off responsibility for specific **[[Shard|Shards]]** while maintaining **[[Linearizability|Linearizability]]**.

## The Core Challenge

All replicas within a group must agree on exactly when a reconfiguration occurs relative to client requests.
- **Example**: If a `Put` arrives during a configuration change, the group must decide if it happened *before* or *after* the shift. 
- **Solution**: Reconfigurations are logged as commands in the [[Multi-Paxos|Multi-Paxos]] log, alongside `Put`/`Get` requests. This provides a total ordering of all events.

## Shard Handoff Protocol

When `Config 11` reassigns Shard 5 from Group A to Group B, the following "dance" occurs:

### 1. Detection
Both groups detect the new configuration by polling the Shard Master.

### 2. State Export (Group A)
Group A sees it no longer owns Shard 5. 
- It stops accepting client requests for Shard 5.
- It prepares a snapshot of the Shard 5 data (key-value pairs) and the **At-Most-Once (AMO) state**.

### 3. State Import (Group B)
Group B sees it now owns Shard 5. It cannot serve requests for Shard 5 until it has the data from Group A.

- **The Transfer Payload**: The message sent from A to B must include:
    - **Shard Data**: The actual `Map<String, String>` (key-value pairs) for all keys belonging to that shard.
    - **AMO Metadata**: The `Map<Integer, AMOResult>` (duplicate detection table) for clients that have interacted with that shard.
- **Pull System**: Group B sends a request to Group A for the shard data. This is generally more robust as the receiver controls the timing of the transition.
- **Push System**: Group A proactively sends the data to Group B and waits for an ACK.
    - **Trade-offs**: 
        - **Pull**: Prevents Group A from "overloading" a group that hasn't even reached the new configuration yet.
        - **Push**: Reduces latency if Group A is ready to shed load immediately. However, Group A must **"Freeze"** its state machine snapshot until Group B ACKs, disabling any further client writes to that shard.

### 4. Installation
Group B receives the shard data and merges it into its local state machine.
- **Crucial**: Group B must also install the **Duplicate Detection Table** for those shards to preserve [[Remote Procedure Call (RPC)|exactly-once semantics]].

### 5. Cleanup
Once Group B acknowledges receipt (usually by completing the transition in its own Paxos log), Group A can safely delete the shard data.
- **Edge Case**: Group A cannot delete its data until Group B ACKs it in its own log, in case the transfer message was lost and needs to be resent.

## Why Transfer AMO State?

If a client sent a request to Group A just before the handoff and the response was lost, the client will retry the request at Group B (the new owner). 
- If Group B does not have the client's sequence number from Group A's table, it will execute the request *again*.
- This violates linearizability for non-idempotent operations like `Append`.
- **Mechanism**: The receiver of the shards must update its local `AMOApplication` state with the incoming metadata to ensure seamless request deduplication.

## Linearizable Shard Handovers (The "Handover Dance")

Moving a shard is a complex network-level dance that must preserve **[[Linearizability|Linearizability]]**. You cannot have a window where both Group A and Group B think they own Shard 5.

### Step-by-Step Logic
1. **Freeze (Group A)**: Group A sees that in `Config 11`, it no longer owns Shard 5. It immediately stops accepting client writes for Shard 5. It is now "Ready for Export."
2. **Transfer**: The data is pull/pushed.
3. **Commit**: Reconfigurations must be **COMMITTED** in the log before they take effect. Group A cannot reject client commands until the `new_config` command is committed in its local Paxos log.

## In-Order Processing

Groups must process configurations **one at a time**. 
- In Lab 2, the View Server was blocked until the primary acked the new view. In Lab 4, every group must ensure it proceeds through configurations one by one locally.
- A group cannot skip from `Config 10` to `Config 12`. It must first transition to `11`, perform all necessary shard transfers, and then move to `12`.
- This coordination ensures that even when multiple configurations are issued rapidly, no group "jumps ahead" and loses track of shard ownership.

## Advanced Reconfiguration Coordination

Transitioning between configurations is not just about moving data; it requires strict coordination to avoid "orphaned" shards or inconsistent states.

### 1. Concurrent Configurations
Multiple configurations may be issued in rapid succession. Each configuration might involve a subset of the replica groups or all of them.
- **Group Independence**: Groups must ensure they proceed through configurations **one-by-one**. 
- **The "One-at-a-Time" Rule**: A group cannot jump to `Config 12` just because it's available; it must first resolve its role in `Config 11`, completing all state transfers before moving its local state machine to the next configuration.

### 2. State Transfer Validation (Sequence Numbers)
When data is transferred (pushed or pulled), the receiving group must acknowledge receipt.
- **Sequence Numbers**: Transfers and ACKs must include versioning or sequence numbers to ensure they are valid for the current configuration transition.
- **Safety**: The old owner **cannot delete** its local data until the new owner has committed the data into its own Paxos log. This provides a fallback if the transfer message is lost or corrupted.

### 3. Acceptance of New Requests
A replica group can only begin serving client requests for a new shard once it **knows** it owns the data and the configuration has been committed in its local log.
- **Blocking**: During the "Freeze" period (especially in push systems), client writes must be disabled because the group is sending a snapshot of its state machine. Changing the state after the snapshot is sent but before the ACK is received would create a divergence.

### 4. Committing the Transition
The **Paxos log is the source of truth**. 
- **Sequence**: A group learns about a new configuration $\to$ proposes it to its own Paxos log $\to$ executes the state transfer $\to$ commits the new config.
- **Linearizability**: A server cannot reject client commands for a shard it used to own until the `new_config` command is actually **COMMITTED** in its log. Blocking commands prematurely would violate linearizability.

## Industry Standard Terms

| CSE452 Term | Industry / Standard Term |
| :--- | :--- |
| **Reconfiguration** | Rebalancing / membership change |
| **Shard Handoff** | Shard migration / partition move |
| **Freeze** | Write-blocking / source quiescing |
| **AMO State** | Deduplication / idempotency table |
| **Pull / Push System** | Receiver-driven / sender-driven transfer |

---

## Related
- [[Sharding|Sharding Overview]] — the architecture reconfiguration operates on
- [[Shard Master|Shard Master]] — the service that issues new configurations
- [[Sharded Key-Value Server|Sharded Key-Value Server]] — the ShardStoreServer that performs handoffs
- [[Transactions|Transactions]] — how 2PC interacts with reconfiguration
- [[Linearizability|Linearizability]] — the guarantee handoffs must preserve
- [[Remote Procedure Call (RPC)|Remote Procedure Call (RPC)]] — exactly-once semantics during shard transfer
