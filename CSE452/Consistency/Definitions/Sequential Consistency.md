# Sequential Consistency

**[[Sequential Consistency]]**: A consistency model where all operations appear to be executed in some total order that respects the program order of each individual process. Unlike linearizability, it does not require that the global order respects real-time (wall-clock) precedence.

## Key Properties
- **Program Order**: Operations from the same process must appear in the order they were issued.
- **Total Order**: All processes see the same sequence of operations.
- **Hierarchy**: A **superset** of Linearizability (less strict).
- **No Real-time constraint**: A read can return a stale value if there is a valid total order where that read occurs before the write that updated it.

## Related
- [[CSE452/Consistency/Linearizability and Sequential Consistency|Linearizability and Sequential Consistency (Detailed)]]
- [[CSE452/Consistency/Definitions/Linearizability|Linearizability]]

