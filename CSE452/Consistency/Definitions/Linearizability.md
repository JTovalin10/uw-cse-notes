# Linearizability

**[[Linearizability]]**: The strongest consistency model for single-object operations. It requires that operations appear to take effect atomically at some point between their invocation and response, respecting a single global total order that matches real-time (wall-clock) precedence.

## Key Properties
- **Atomicity**: Operations happen all at once or not at all.
- **Real-time Order**: if operation A finishes before B starts, A must appear before B in the history.
- **Hierarchy**: A **subset** of Sequential Consistency (stricter).
- **Composability**: A system composed of linearizable objects is itself linearizable.

## Related
- [[CSE452/Consistency/Linearizability and Sequential Consistency|Linearizability and Sequential Consistency (Detailed)]]
- [[CSE452/Consistency/Definitions/Sequential Consistency|Sequential Consistency]]

