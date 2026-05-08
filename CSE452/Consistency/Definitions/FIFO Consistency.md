# FIFO Consistency

**[[FIFO Consistency]]**: (Also known as **PRAM Consistency**) A consistency model that guarantees that writes from a single process are seen by all other processes in the order they were issued, but makes no guarantees about the relative ordering of writes from different processes.

## Key Properties
- **Simple Implementation**: Can be achieved by buffering writes at the source and applying them in order at the destination.
- **Weakest of the "Order" Models**: It is weaker than Causal Consistency because it doesn't track cross-process dependencies.

## Related
- [[CSE452/Consistency/Definitions/Processor Consistency|Processor Consistency]]
- [[CSE452/Consistency/Definitions/Causal Consistency|Causal Consistency]]
