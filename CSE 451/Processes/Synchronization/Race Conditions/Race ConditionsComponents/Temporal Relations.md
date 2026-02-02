# What is it
the ordering relationship between events in concurrent execution

# Key points
- Single threaded applications are executed sequentially
- Absent [[Synchronization]], instructions executed by distinct threads must be considered unordered/simultaneous

# Why it matters
- without explicit ordering, [[Race Condition]]s can occur
- [[Mutual Exclusion]] provides ordering guarantees

# Related
- [[Interleaved Schedules]]
- [[Critical Sections]]
