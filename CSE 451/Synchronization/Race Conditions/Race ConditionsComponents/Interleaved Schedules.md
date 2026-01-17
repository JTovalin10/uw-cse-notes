# What is it
- the execution of multiple threads can be interleaved, assuming preemptive scheduling

![[Pasted image 20260117080947.png]]

# Why it causes problems
- any interleaving is possible without synchronization
- leads to [[Race Condition]]s
- makes bugs non-deterministic ([[Heisenbug]])

# Solution
- protect [[Critical Sections]] with [[Locks]] or other synchronization mechanisms
- enforce [[Mutual Exclusion]]

# Related
- [[Temporal Relations]]
- [[Critical Section Patterns]]
