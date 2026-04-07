# CSE452: Remote Procedure Call (RPC)

## Background

- **Serialization**: the process of converting data (objects, structs) into bytes for transmission over the network
- **Procedure**: old word for function/method — RPC makes a remote function call look like a local one
- **Marshalling**: converting typed arguments into a byte stream for the network (= serialization of function arguments)
- **Unmarshalling**: converting the received byte stream back into typed arguments (= deserialization)

### Stub and Skeleton

RPC hides the network from the programmer through generated code:

- **Stub** (client side): a generated function with the same signature as the real remote function
  - The caller just calls the stub as if it were a normal local function
  - The stub marshals the arguments, sends the request message, waits for the response, and returns the result
- **Skeleton** (server side): generated server-side code that receives an incoming RPC
  - Unmarshals the arguments from bytes back into typed values
  - Calls the actual implementation function
  - Marshals the return value and sends it back

This makes RPC **transparent** to the application code — the caller doesn't know (or care) that the call crosses a machine boundary.

## Protocol

A **protocol** specifies:
- What code to run on each machine
- What data to store on each machine
- How machines communicate to solve a problem under a given [[CSE452/RPC/Fault Model|Fault Model]]

A protocol is **correct** if, in any execution and under any failure within the fault model, it behaves as advertised.

---

## How RPC Works

### Request Message (Client → Server)
- Name of the method to call
- All arguments — passed **by value** over the network (pointers cannot be passed)
  - Passing a pointer would send the address, which is meaningless on another machine
  - Best case result: segfault on the server; worst case: it points to valid but wrong memory

### Response Message (Server → Client)
- How the method terminated (success or failure)
- Return value (on success)

---

## Request ID and Deduplication

Because the network can drop messages (see [[CSE452/RPC/Fault Model|Fault Model]]), clients retransmit requests that appear to have been lost. This creates a problem: the server may execute the same request twice.

**Solution**: attach a **sequence number (seqnum)** to every new message.

### What the Server Stores
- A set of already-executed sequence numbers
- The result for each executed request — so if the client retransmits, the server returns the cached result without re-executing

### Space Cost
- Naïve: store all executed seqnums → grows $O(n)$ per client, $O(nm)$ for $m$ clients
- Optimization: store only the **highest seqnum per client** → $O(m)$ space
  - Requires that one client never has two concurrent in-flight requests
- For evicting old entries, see [[CSE451/Memory Management/Address Translation/TLB/Translation Lookaside Buffer (TLB) Replacement Policies|TLB Replacement Policies]] for analogous eviction strategies

### Multiple Clients
- Server stores a set of `(client_id, seqnum, response)` triples
- Optimized to highest seqnum per client → $O(m)$ where $m$ = number of clients

---

## Types of RPC

| Type | Mechanism | Guarantee |
|------|-----------|-----------|
| **At-Least-Once RPC** | RPC + retransmission | Server executes the request ≥ 1 time |
| **At-Most-Once RPC** | RPC + deduplication | Server executes the request ≤ 1 time |
| **Exactly-Once RPC** | RPC + retransmission + deduplication | Server executes the request exactly 1 time |

- At-least-once is safe only for **idempotent** operations — see [[CSE452/Primary-Backup/Idempotence|Idempotence]]
- Exactly-once requires both retransmission (so the request eventually arrives) and deduplication (so it runs only once)

---

## Related
- [[CSE452/RPC/Fault Model|Fault Model]] — the failures RPC must handle (drops, duplicates, delays)
- [[CSE452/Primary-Backup/Idempotence|Idempotence]] — why at-least-once RPC is only safe for idempotent operations
- [[CSE452/RPC/Deterministic State Machine|Deterministic State Machine]] — formal model for replicating state across machines
- [[CSE452/Primary-Backup/Primary Backup|Primary-Backup Replication]] — uses RPC between primary and backup
- [[CSE452/Primary-Backup/Why not just use TCP|Why Not Just Use TCP]] — why TCP is insufficient for distributed systems
