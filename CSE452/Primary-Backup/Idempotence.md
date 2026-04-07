# CSE452: Idempotence

## What is Idempotence?

An operation is **idempotent** if applying it multiple times has the same effect as applying it exactly once:

$$f(f(x)) = f(x)$$

**Examples**:
- `SET x = 5` is idempotent — running it twice leaves `x = 5` either way
- `INCREMENT x` is **not** idempotent — running it twice gives a different result than once

## Relevance to Distributed Systems

Idempotence is critical when using **At-Least-Once RPC** (see [[CSE452/RPC/Remote Procedure Call (RPC)|RPC]]). Because the client retransmits on suspected failure, the server may execute the same request more than once. If the operation is idempotent, duplicate execution causes no harm. If it is not, you need deduplication at the server.

- **Idempotent** → At-Least-Once RPC is safe
- **Not idempotent** → need At-Most-Once or Exactly-Once RPC

Not all operations can be made idempotent. For those that cannot, server-side deduplication via sequence numbers (see [[CSE452/RPC/Remote Procedure Call (RPC)#Request ID and Deduplication|Request ID]]) is the standard solution.

---

## Related
- [[CSE452/RPC/Remote Procedure Call (RPC)|Remote Procedure Call (RPC)]] — where idempotence determines which RPC type is safe to use
- [[CSE452/Primary-Backup/Primary Backup|Primary-Backup Replication]] — state transfer and re-applied operations need care around idempotence
- [[CSE452/RPC/Fault Model|Fault Model]] — dropped messages cause retransmission, making idempotence relevant
