# What is it
a program has a race condition or data race if the result of an execution depends on timing. (non-deterministic)

# Why they occur
- [[Temporal Relations]] - without synchronization, instructions from distinct threads are unordered
- [[Interleaved Schedules]] - preemptive scheduling can interleave thread execution

# Debugging
- [[Heisenbug]] - bugs that disappear when you try to observe them

# How to prevent
- [[Critical Sections]] - identify and protect shared data access
- [[Mutual Exclusion]] - ensure operations are not simultaneous
- [[Locks]] - enforce ordering with acquire/release

# Related
- [[Critical Section Patterns]]
