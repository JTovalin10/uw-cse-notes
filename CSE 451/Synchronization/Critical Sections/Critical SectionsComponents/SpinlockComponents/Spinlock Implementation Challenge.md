## Implementation challenge
problem is that implementation of spinlocks has [[Critical Sections]] too
- acquire/release must be [[Atomic]]
- needs help from hardware

### Hardware support
- atomic instructions
	- [[test_and_set]]
	- [[compare_and_swap]] (cmpxchg)
- disable/reenable interrupts
	- to prevent context switches
