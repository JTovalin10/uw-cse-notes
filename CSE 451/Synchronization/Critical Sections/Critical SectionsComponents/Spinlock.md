# Implementing
problem is that implmentation of spinlocks has [[Critical Sections]] too
- acquire/release must be [[Atomic]]
- needs help from hardware
	- atomic instructions
		- test_and_set
		- Cmpxchg
	- disable/reenable interrupts
		- to prevent context swithces
