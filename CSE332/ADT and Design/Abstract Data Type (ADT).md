# CSE 332: Abstract Data Type (ADT)

An **Abstract Data Type (ADT)** is a mathematical description of a data type that defines the behavior (operations and their properties) but does not describe how it is implemented.

- Example: A **List** ADT specifies operations like `get(i)`, `insert(i, v)`, and `remove(i)`, but says nothing about whether it is backed by an array or a linked list.
- The implementation is hidden behind the interface — the user of the ADT only cares about *what* it does, not *how*.

ADTs allow us to reason about correctness and compare algorithms independently of specific hardware or language choices.

## Related
- [[CSE332/Dictionaries/Dictionaries|Dictionaries]]
- [[CSE332/Priority Queues/Priority Queues|Priority Queues]]
