# CSE451: clone

The **`clone()`** syscall is similar to **[[Fork|Fork]]** in that it creates a new process, but instead of unconditionally duplicating the entire address space, it copies only what is necessary. The caller can selectively choose which resources (address space, file descriptor table, signal handlers, etc.) are shared with the parent versus given to the child as a fresh private copy.

This is one of the two solutions identified in [[Optimizing Fork|Optimizing Fork]] for avoiding the cost of a naive full address-space copy on every process creation — the other being [[vfork|vfork]]. Because `clone()` exposes fine-grained control over what is shared, it is also the underlying mechanism Linux uses to implement threads: a "thread" is simply a process created via `clone()` with the address space, file descriptor table, and other resources marked as shared rather than copied (see [[Process vs Thread|Process vs Thread]] for what threads share vs. don't share).

## Related
- [[Fork|Fork]]
- [[vfork|vfork]]
- [[Optimizing Fork|Optimizing Fork]]
- [[Process vs Thread|Process vs Thread]]

## Industry Standard Terms
| Course Term | Industry-Standard Equivalent |
|---|---|
| clone() | Linux thread/process creation primitive (`CLONE_*` flags) |

