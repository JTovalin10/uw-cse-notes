# Distributed Systems: Linearizability

**Linearizability** is the strongest consistency model for single-object operations. It requires that operations appear to take effect atomically at some point between their invocation and response, respecting a single global total order that matches real-time (wall-clock) precedence.

## Key Properties

- **Atomicity**: Operations happen all at once or not at all.
- **Real-time Order**: If operation A finishes before B starts, A must appear before B in the history.
- **Hierarchy**: A **subset** of [[Strong Consistency Models#Sequential Consistency|Sequential Consistency]] (stricter).
- **Composability**: A system composed of linearizable objects is itself linearizable.

## Industry Standard Terms

| CSE452 Term | Industry / Standard Term |
| :--- | :--- |
| **Linearizability** | Atomic consistency / strong consistency |
| **Linearization Point** | Commit point / atomic visibility point |

## Related

- [[Strong Consistency Models|Strong Consistency Models]] — detailed treatment of linearizability, proofs, and the comparison with sequential consistency
- [[Consistency|Consistency]] — the consistency-model hub
