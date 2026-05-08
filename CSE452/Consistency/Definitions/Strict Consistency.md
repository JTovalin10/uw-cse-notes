# Strict Consistency

**[[Strict Consistency]]**: The strongest theoretical consistency model. It requires that any read on a data item $x$ returns a value corresponding to the result of the most recent write on $x$.

## Key Properties
- **Absolute Global Time**: Relies on a shared, perfectly synchronized global clock.
- **Impossible to Implement**: In a distributed system, the speed of light and network latency make it impossible for all nodes to see a write "instantly."
- **Theoretical Benchmark**: Used as a baseline to compare real-world models like Linearizability.

## Related
- [[CSE452/Consistency/Definitions/Linearizability|Linearizability]]
- [[CSE452/Consistency/Memory Consistency|Memory Consistency]]
