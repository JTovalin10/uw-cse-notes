# OS Structure Overview

The [[Operating System]] sits between application programs and the hardware:
- It mediates access and abstracts away ugliness
- Programs request services via [[Traps]] or [[CSE351/System Programming/Exceptions]]
- Devices request attention via [[Interrupts]]

![[Screenshot 2026-01-14 at 4.51.51 PM.png]]
![[Screenshot 2026-01-14 at 4.52.26 PM.png]]
![[Screenshot 2026-01-14 at 4.52.41 PM.png]]

# Monolithic Architecture

Traditionally, OS were built as a monolithic entity

![[Pasted image 20260114213634.png]]

## Advantages
- Cost of module interaction is low

## Disadvantages
- Hard to understand
- Hard to modify
- Unreliable
- Hard to maintain

# Layered Architecture

![[Pasted image 20260114213758.png]]

## Problems with Layering
- Imposes hierarchical structure
	- But real systems are more complex
		- File system requires VM services (buffers)
		- VM would like to use files for its backing store
	- Strict layering isn't flexible enough
- Poor performance
	- Each layer crossing has overhead associated with it
- Disjunction between model and reality
	- System modeled as layers, but not really built that way
