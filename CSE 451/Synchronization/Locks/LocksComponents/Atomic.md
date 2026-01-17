# What is it
executes as though it cannot be interrupted

"all or nothing"

# Why it matters
- without atomicity, operations can be interleaved
- leads to [[Race Condition]]s
- example: `counter++` is NOT atomic (read-modify-write)

# Atomic instructions
hardware provides atomic instructions for synchronization:
- [[test_and_set]]
- [[compare_and_swap]]

# What makes an instruction atomic
- hardware guarantees indivisibility
- no other processor can observe intermediate state
- memory bus locking or cache coherence protocols

# Related
- [[Locks]]
- [[Spinlock]]
- [[Critical Sections]]
