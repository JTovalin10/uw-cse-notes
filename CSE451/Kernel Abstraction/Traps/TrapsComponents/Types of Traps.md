# CSE451: Types of Traps

Traps fall into two broad categories:

## 1. Intentional (System Calls)
The process voluntarily requests OS assistance for something it cannot do itself.

**Example:** code calls `printf()`, which internally calls `write()`. The process cannot write to the screen directly, so it executes a trap to ask the OS to do it.

## 2. Unintentional (Exceptions / Faults)
The process did something illegal or nonsensical.

**Examples:**
- Divide by zero
- Access memory you don't own (segfault)
- Execute an invalid instruction

**Result:** the trap handler for these errors usually kills the process (or sends it a signal like SIGSEGV).

## Related
- [[Traps]] — the parent concept
- [[System Call]] — intentional traps
- [[Exception]] — unintentional traps caused by hardware errors
- [[Dealing with Exceptions]] — OS responses to unintentional traps
- [[How Traps Work]] — the mechanism behind both types
