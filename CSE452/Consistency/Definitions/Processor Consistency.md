# Processor Consistency

**[[Processor Consistency]]**: A consistency model where writes issued by a single process are seen by all other processes in the order they were issued. However, writes from different processes may be seen in different orders by different observers.

## Key Properties
- **Per-Process Ordering**: Guarantees that the sequence of writes from any individual processor is preserved globally.
- **No Global Interleaving Guarantee**: Two different processes might see the interleaving of writes from other processes differently.

## Related
- [[CSE452/Consistency/Definitions/FIFO Consistency|FIFO Consistency]]
- [[CSE452/Consistency/Memory Consistency|Memory Consistency]]
