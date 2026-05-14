# Lab 4: Sharded Key-Value Server

Each **ShardStoreServer** operates as part of a **[[Sharding/Sharding#Replica Group|Replica Group]]**, serving client requests for the **[[Sharding/Sharding#Shard (The Unit of Data)|Shards]]** assigned to it by the **[[Sharding/Sharding#ShardMaster|Shard Master]]**.

## Internal Architecture: The Sub-Node Pattern

To ensure fault tolerance within each partition, every replica group implements its own [[CSE452/Paxos/Multi-Paxos|Multi-Paxos]] cluster using a **Composite Node** pattern.

### Sub-Node Paxos Setup
The `ShardStoreServer` acts as the "Root Node" and instantiates a `PaxosServer` as a sub-node. Instead of executing commands directly, the Paxos sub-node notifies the parent `ShardStoreServer` of every decision in order.

```java
// Simplified sub-node initialization
PaxosServer paxosServer = new PaxosServer(paxosAddress, paxosAddresses, address());
addSubNode(paxosServer);
paxosServer.init();
```

### Decision Flow
1.  **Client Request**: A client sends an RPC to the `ShardStoreServer`.
2.  **Proposal**: The server wraps the request in a `Command` and passes it to the local `PaxosServer` via `handleMessage`.
3.  **Consensus**: The `PaxosServer` runs Multi-Paxos with its peers in the replica group.
4.  **Notification**: Once a value is chosen for a slot, the `PaxosServer` notifies the parent `ShardStoreServer`.
5.  **Execution**: The parent node executes the command and returns the result to the client.

### State Machine Structure (The AMO Wrapper)
The server wraps a `KVStore` inside an **`AMOApplication`** (At-Most-Once). This is the key to maintaining [[CSE452/RPC/Remote Procedure Call (RPC)|exactly-once semantics]] in a sharded environment.

- **Internal State**: The `AMOApplication` tracks a mapping of `ClientID -> {LastSequenceNumber, LastResult}`.
- **Deduplication Logic**: Before execution, the application checks if the sequence number has already been seen for that client. If so, it returns the cached result.
- **Shard Transfer Impact**: When a shard moves, this state must move with it. If Group B receives Shard 5 but not the AMO metadata for the clients using Shard 5, Group B might execute a retried request a second time.

## Client Interaction

1.  **Key Mapping**: Clients use `keyToShard(key)` in `ShardStoreNode` to find which shard a key belongs to.
2.  **Routing**: The client queries the **Shard Master** for the current configuration to find the group responsible for that shard. It uses `SingleKeyCommand.key()` to determine the key for an operation.
3.  **RPC Execution**: The client sends the request (`Get`, `Put`, or `Append`) to the group.
4.  **Error Handling**: If a server receives a request for a shard it does not own, it returns an error. The client then re-queries the Shard Master and retries.

## Communication & Fault Tolerance

- **Inter-Group Communication**: The easiest way for a replica/group to send a message to a different group is by **broadcasting** the message to the entire group.
- **Fault Tolerance Assumptions**: A majority of servers in each replica group must be alive and able to communicate with:
    - A majority of the **Shard Master** servers.
    - A majority of every other replica group.
- **Paxos Optimization**: Your Paxos implementation should be able to reach agreement in a **single step** when there is only one server in the group. This is crucial for efficient search testing.

## Configuration Polling

Servers periodically send `Query` operations to the Shard Master to learn about new configurations.
- **Read-Only Queries**: To avoid unnecessary sequence numbers, `Query` operations can be handled as non-AMO read-only commands in Paxos.
- **Sequential Processing**: Servers must process configurations one at a time, in order. A server cannot move to `Config 12` until it has fully completed the transition to `Config 11`.

## Implementation Notes
- **Complexity**: A typical solution for Part 2 takes approximately 350 lines of code.
- **Paxos Obliviousness**: As a sub-node, Paxos should be oblivious to `AMOApplication` logic and should be able to decide the same command for different slots. Avoid overly aggressive de-duplication at the Paxos level.

## Related
- [[CSE452/Sharding/Sharding|Sharding Overview]]
- [[CSE452/Sharding/Reconfiguration|Reconfiguration & Handoff]]
- [[CSE452/RPC/Remote Procedure Call (RPC)|At-Most-Once Semantics]]
- [[CSE452/RPC/Deterministic State Machine|Replicated State Machine]]
